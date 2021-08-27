FROM nfcore/base:1.13.3
LABEL authors="Peter J Bailey, Alexander Peltzer, Olga Botvinnik" \
      description="Docker image containing all software requirements for the nf-core/scrnaseq pipeline"

RUN conda install -c conda-forge mamba -y

# Install the conda environment
COPY environment.yml /
RUN mamba env create -f /environment.yml && conda clean -a

# The conda bug with tbb - salmon: error while loading shared libraries: libtbb.so.2
# pandoc via conda was not working
RUN apt-get update && apt-get install -y libtbb2 pandoc-citeproc

# Add conda installation dir to PATH (instead of doing 'conda activate')
ENV PATH /opt/conda/envs/lifebit-ai-scrnaseq-1.2.0/bin:$PATH

# Dump the details of the installed packages to a file for posterity
RUN conda env export --name lifebit-ai-scrnaseq-1.2.0 > lifebit-ai-scrnaseq-1.2.0.yml
