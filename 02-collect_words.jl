# 02-collect_words.jl
# Copies words subsetted in 01-generate_random_subset into new folders
using ProgressBars

# Input folder variables
const sr_in = "sR"
const sk_in = "sK"
const sj_in = "sJ"

# Output folder variables
const sr_out = "sR_sub"
const sk_out = "sK_sub"
const sj_out = "sJ_sub"

if ! isdir(sr_out) mkdir(sr_out) end
if ! isdir(sk_out) mkdir(sk_out) end
if ! isdir(sj_out) mkdir(sj_out) end

filenames = open("subset_words.txt") do f readlines(f) end
words = [f * ".wav" for f in filenames]

for word in ProgressBar(words)
	sr_origin = joinpath(sr_in, word)
	sk_origin = joinpath(sk_in, word)
	sj_origin = joinpath(sj_in, word)
	
	sr_destination = joinpath(sr_out, word)
	sk_destination = joinpath(sk_out, word)
	sj_destination = joinpath(sj_out, word)
	
	cp(sr_origin, sr_destination)
	cp(sk_origin, sk_destination)
	cp(sj_origin, sj_destination)
end
