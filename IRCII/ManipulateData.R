data935 <- biomformat::read_biom("OTU Table Data/OtuTable935.biom")
OTU935 <- as.data.frame(as.matrix(biom_data(data935)))
TAX935 <- observation_metadata(data935)

data936 <- biomformat::read_biom("OTU Table Data/OtuTable936.biom")
OTU936 <- as.data.frame(as.matrix(biom_data(data936)))
TAX936 <- observation_metadata(data936)

data937 <- biomformat::read_biom("OTU Table Data/OtuTable937.biom")
OTU937 <- as.data.frame(as.matrix(biom_data(data937)))
TAX937 <- observation_metadata(data937)

data938 <- biomformat::read_biom("OTU Table Data/OtuTable938.biom")
OTU938 <- as.data.frame(as.matrix(biom_data(data938)))
TAX938 <- observation_metadata(data938)

data939 <- biomformat::read_biom("OTU Table Data/OtuTable939.biom")
OTU939 <- as.data.frame(as.matrix(biom_data(data939)))
TAX939 <- observation_metadata(data939)


Map <- read_tsv("OTU Table Data/Map.txt")
EarlyDaysMap <- Map %>% filter(between(as.numeric(day_of_life),0,2), mom_child == "C") %>% distinct(studyid, .keep_all = TRUE)

Samples935 <- intersect(colnames(OTU935), EarlyDaysMap$sample_name)
EarlyOTU935 <- OTU935 %>% select(Samples935)

Samples936 <- intersect(colnames(OTU936), EarlyDaysMap$sample_name)
EarlyOTU936 <- OTU936 %>% select(Samples936)

Samples937 <- intersect(colnames(OTU937), EarlyDaysMap$sample_name)
EarlyOTU937 <- OTU937 %>% select(Samples937)

Samples938 <- intersect(colnames(OTU938), EarlyDaysMap$sample_name)
EarlyOTU938 <- OTU938 %>% select(Samples938)

Samples939 <- intersect(colnames(OTU939), EarlyDaysMap$sample_name)
EarlyOTU939 <- OTU939 %>% select(Samples939)


EarlyOTUTable935 <- otu_table(EarlyOTU935, taxa_are_rows = TRUE)
phylo935 <- phyloseq(EarlyOTUTable935)

EarlyOTUTable936 <- otu_table(EarlyOTU936, taxa_are_rows = TRUE)
phylo936 <- phyloseq(EarlyOTUTable936)

# There are no samples left in the 937 table

EarlyOTUTable938 <- otu_table(EarlyOTU938, taxa_are_rows = TRUE)
phylo938 <- phyloseq(EarlyOTUTable938)

EarlyOTUTable939 <- otu_table(EarlyOTU939, taxa_are_rows = TRUE)
phylo939 <- phyloseq(EarlyOTUTable939)

EarlyDaysMap <- as.data.frame(EarlyDaysMap)
rownames(EarlyDaysMap) <- EarlyDaysMap$sample_name
EarlyDaysMap$sample_name <- NULL
Samples <- sample_data(EarlyDaysMap)

Tree <- read.tree("OTU Table Data/NewickTree.txt")

phylo <- merge_phyloseq(phylo935, phylo936, phylo938, phylo939, Samples, Tree)
