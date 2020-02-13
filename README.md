# mirdeep2_rfam14.1

miRDeep2 expects to find the Rfam_index.*.ebwt files in /opt/conda/bin/indexes. 
This is a problem when running with Singularity because that is not a writable directory. 
When building this container the most recent version of Rfam fasta files were downloaded, indexed with Bowtie 
and added to the container in /opt/conda/bin/indexes.

Updates to Rfam will required updates to the container.
