These are practices of RNA-seq pathway analysis using a small portion of GEO [GSE135378](https://www.ncbi.nlm.nih.gov/gds/?term=GSE135378[Accession]) dataset. See Pappalardi MB, et al. https://doi.org/10.1038/s43018-021-00249-x for original work. 

Differential expression analysis was done with DESeq2. Pathway analysis was performed for GO ontology and MSigDb gene sets with [clusterProfiler](https://www.bioconductor.org/packages/release/bioc/html/clusterProfiler.html) and [fgesa](https://bioconductor.org/packages/release/bioc/html/fgsea.html).  

The script pappalardi_pathway_ncbi used NCBI processed raw count downloaded from GEO site, while pappalardi_pathway_salmon used count matrix we prepared with SRA reads and [Salmon](https://salmon.readthedocs.io/en/latest/salmon.html). Please see the Salmon shell scripts and info directory for related SRA info files. Our count files were not included. Besides difference in count matrix used, downstream analyses are the same.

The scripts can be adapted for analyzing other samples.
