using DataFrames
using BSON
using ProgressBars
using Statistics
using CSV

cd("C:/Users/Matt/Dropbox/projects/phoneme_actions")

function read_files(scale_f=sqrt)
    rows = []
    dirs = readdir("word_results")
    for d in ProgressBar(dirs)
        p = joinpath("word_results", d)
        res = [BSON.load(joinpath(p, x))[:dat] for x in readdir(p)]
        for i in 1:length(res)
            res[i][:label] = dirs[i]
        end
        # t10 = partialsort(res, 1:10, by=x->x[:d] / sqrt(maximum(x[:path2])))
        sort!(res, by=x->x[:d] / scale_f(maximum(x[:path2])))
        position = findall(x->x[:label] == d, res)[1]
        t10 = [x[:label] for x in res[1:10]]
        push!(rows, [d; t10; position])
    end
    tab = reduce(vcat, reshape(x, 1, :) for x in rows)
    colnames = ["num$i" for i in 1:10]
    colnames = ["word"; colnames; "position"]
    d = DataFrame(tab, colnames)
    # rename!(d, colnames)
    return d
end

d = read_files()
CSV.write("scores_top10.csv", d, delim=',')

d_log = read_files(log)
CSV.write("scores_top10log.csv", d, delim=',')