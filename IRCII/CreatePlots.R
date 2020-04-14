png("Plots/Alpha-Diversity.png")
plot_richness(phylo, x = "delivery")
dev.off()

deliveryMode <- substring(sample_data(phylo)$delivery,1,3)
sample_names(phylo) <- paste0(substring(sample_names(phylo), 7,10), deliveryMode)

WeightedUni <- UniFrac(phylo, weighted = TRUE)
UnweightedUni <- UniFrac(phylo, weighted = FALSE)




png("Plots/WeightedUniFracDendrogram.png")
plot(hclust(WeightedUni), main = "Weighted UniFrac Sample Dendrogram")
dev.off()
png("Plots/UnweightedUniFracDendrogram.png")
plot(hclust(UnweightedUni), main = "Unweighted UniFrac Sample Dendrogram")
dev.off()



WeightedOrd = ordinate(phylo, "PCoA", "unifrac", weighted=TRUE)
png("Plots/WeightedUniFracPCoA.png")
plot_ordination(phylo, WeightedOrd, color="delivery")
dev.off()

UnweightedOrd = ordinate(phylo, "PCoA", "unifrac", weighted=FALSE)
png("Plots/UnweightedUniFracPCoA.png")
plot_ordination(phylo, UnweightedOrd  , color="delivery")
dev.off()
