# 05-top10_scores.jl
# Calculate top 10 scores from DTW comparisons,
# optionally using a scaling function

using DataFrames
using BSON
using ProgressBars
using Statistics
using CSV

function read_files(scale_f=sqrt)
    rows = []
    dirs = readdir("word_results")
    for d in ProgressBar(dirs)
        p = joinpath("word_results", d)
		res = []
        for (i, x) in enumerate(readdir(p))
			r = BSON.load(joinpath(p, x))[:dat]
			r = (r..., label=dirs[i])
			push!(res, r)
        end
        sort!(res, by=x->x[:d] / scale_f(maximum(x[:path2])))
        position = findall(x->x[:label] == d, res)[1]
        t10 = [x[:label] for x in res[1:10]]
        push!(rows, [d; t10; position])
    end
    tab = reduce(vcat, reshape(x, 1, :) for x in rows)
    colnames = ["num$i" for i in 1:10]
    colnames = ["word"; colnames; "position"]
    d = DataFrame(tab, colnames)
    return d
end

d = read_files()
CSV.write("scores_top10.csv", d, delim=',')
