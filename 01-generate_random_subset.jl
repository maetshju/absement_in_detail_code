# 01-generate_random_subset.jl
# Generates the random subset of 1000 MALD words used in experiment
using Random

rng = Xoshiro(220312)
filenames = open("mald_words_in_common.txt") do f readlines(f) end
shuffle!(rng, filenames)
open("subset_words.txt", "w") do w
	for fname in filenames[1:1001] # need 1001 since "DECKHAND" is broken
		if fname == "DECKHAND" continue end
		write(w, fname)
		write(w, "\n")
	end
end
