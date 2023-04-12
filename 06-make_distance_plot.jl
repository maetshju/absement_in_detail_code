# 06-make_distance_plot.jl
# Generate bar-/histogram-style plot of distance values
# between "AFTERNOONS" and "AFFECTION"

using Plots
using DynamicAxisWarping
using BSON
using Distances
using LinearAlgebra

function main()
	afternoons = BSON.load("sR_mfcc/AFTERNOONS.bson")[:m]
	affection = BSON.load("sR_mfcc/AFFECTION.bson")[:m]
	
	d, p1, p2 = dtw(afternoons, affection, euclidean)
	dists = [euclidean(afternoons[:,t1], affection[:,t2]) for (t1, t2) in zip(p1, p2)]
	diffs = [afternoons[:,t1] .- affection[:,t2] for (t1, t2) in zip(p1, p2)]
	println("absement:\t", reduce(+, diffs))
	println("absement magnitude:\t", norm(reduce(+, diffs)))
	println("dtw cost:\t", d)
	dists = [sum(dists[p1 .== i]) for i in 1:p1[end]]
	bar(dists, lw=1.2, fill=(0, 0.5), label="", xlabel="Time step", ylabel="Distance", title="DTW(afternoons, affection)", size=(600, 400))
	savefig("distance_over_time.pdf")
end

main()
