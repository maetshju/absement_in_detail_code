# 03-calculate_mfccs.jl
# Calculates MFCCs for the words in selected subset for each speaker

using Phonetics
using ProgressMeter
using BSON: @save
using Random

const sr_subset = "sR_sub"
const sk_subset = "sK_sub"
const sj_subset = "sJ_sub"

const sr_m = "sR_mfcc"
const skj_m = "sKJ_mfcc"

if ! isdir(sr_m) mkdir(sr_m) end
if ! isdir(skj_m) mkdir(skj_m) end

Random.seed!(120322)

function main()
	@showprogress "sR MFCC" for w in readdir(sr_subset)
		p = joinpath(sr_subset, w)
		s = Sound(p)
		m = sound2mfcc(s, useFrameEngery=false, dither=true)
		o = joinpath(sr_m, replace(w, ".wav" => ".bson"))
		@save o m
	end
	
	@showprogress "sKJ MFCC" for w in readdir(sk_subset)
		p1 = joinpath(sk_subset, w)
		p2 = joinpath(sj_subset, w)
		sk = Sound(p1)
		sj = Sound(p2)
		skm = sound2mfcc(sk, useFrameEngery=false, dither=true)
		sjm = sound2mfcc(sj, useFrameEngery=false, dither=true)
		m = avgseq([sk, sj], center=:rand)
		o = joinpath(skj_m, replace(w, ".wav" => ".bson"))
		@save o m
	end
end

main()
