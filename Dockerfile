FROM ubuntu:24.04
LABEL author="Somak Roy <roysomak4@gmail.com>"

ENV PATH=$PATH:$HOME/bin
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    python3 \
    python3-pip \
    git \
    wget \
    build-essential \
    libz-dev \
    libglib2.0-dev \
    libbz2-dev \
    liblzma-dev \
    default-jre \
    autoconf \
    samtools && \
mkdir $HOME/bin && \
apt-get clean && rm -rf /var/lib/apt/lists/* && \
pip3 install --upgrade pip && \
wget https://github.com/dzerbino/velvet/archive/refs/tags/v1.2.10.tar.gz && \
tar -xvzf v1.2.10.tar.gz && \
cd velvet-1.2.10 && \
make && \
cp velvetg $HOME/bin && \
cp velveth $HOME/bin && \
cd .. && rm -rf v1.2.10.tar.gz velvet-1.2.10 && \
git clone https://github.com/adamewing/exonerate.git && \
cd exonerate && \
autoreconf -fi  && \
./configure && make && make install && \
cd .. && rm -rf exonerate && \
wget https://github.com/broadinstitute/picard/releases/download/2.27.3/picard.jar && \
chmod +x picard.jar && \
export BAMSURGEON_PICARD_JAR=$HOME/picard.jar && \
wget https://github.com/bwa-mem2/bwa-mem2/releases/download/v2.3/bwa-mem2-2.3_x64-linux.tar.bz2 && \
tar -jxvf bwa-mem2-2.3_x64-linux.tar.bz2 && \
cp bwa-mem2-2.3_x64-linux/bwa-mem2* $HOME/bin/ && \
rm -rf bwa-mem2-2.3_x64-linux* && \
pip install pysam && \
git clone https://github.com/adamewing/bamsurgeon.git && \
cd bamsurgeon