# 04-calculate_warping.jl
# Calculate the DTW between one speaker and the average of the other two

using DynamicAxisWarping
using BSON
using Distances
using ProgressBars

const outdir = "word_results"
if ! isdir(outdir) mkdir(outdir) end

const sr = "sR_mfcc"
const skj ="sKJ_mfcc"

struct dtw_res
	d::Float64
	path1::String
	path2::String
	d_time::String
	absement_time::Float64
end

function calc_path(s1, s2)
	d, path1, path2 = dtw(s1, s2, euclidean)
	dist_diff = [euclidean(s1[:,i], s2[:,j]) for (i, j) in zip(path1, path2)]
	accum = cumsum(dist_diff)
	
	dat = (d=d, path1=path1, path2=path2, d_time=dist_diff, absement_time=accum)
end

function main()
	wordfilenames = readdir(sr)
	for word_sR in ProgressBar(wordfilenames), word_sKJ in wordfilenames
	
		wordname = splitext(word_sR)[1]
		if ! isdir(joinpath(outdir, wordname)) mkdir(joinpath(outdir, wordname)) end
		sR_path = joinpath(sr, word_sR)
		sR_m = BSON.load(sR_path)[:m]
		
		
		comparatorname = splitext(word_sKJ)[1]
		sKJ_path = joinpath(skj, word_sKJ)
		sKJ_m = BSON.load(sKJ_path)[:m]
		
		dat = calc_path(sR_m, sKJ_m)
		BSON.@save joinpath(outdir, wordname, "$(comparatorname).bson") dat
	end
end

main()
