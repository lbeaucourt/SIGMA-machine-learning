FROM ubuntu:16.04

RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.internode.on.net\/pub\/ubuntu/g' /etc/apt/sources.list

RUN  apt-get update
RUN  apt-get upgrade -y

# Install python packages 
RUN  apt-get install -y python3

# Install compile tools 
RUN  apt-get install -y python3-dev gfortran libatlas-base-dev libfreetype6-dev libxft-dev libpng-dev g++ make patch lib32ncurses5-dev

# Install dependencies tools 
RUN apt-get install -y wget vim
RUN wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
RUN python3 /tmp/get-pip.py
RUN apt-get install -y git
RUN pip install --upgrade pip

# Install Cython,Joblib,...
RUN  pip install cython
RUN  pip install joblib
RUN  pip install ipdb

# Install core packages 
RUN  pip install -U numpy
RUN  pip install -U scipy
RUN  pip install -U matplotlib
RUN  pip install -U notebook 
RUN  pip install --upgrade jupyter
RUN  pip install -U pandas
RUN  pip install -U scikit-learn
RUN  pip install -U networkx
RUN  pip install -U tqdm
RUN  pip install -U xlrd
RUN  pip install -U xlsxwriter
RUN  apt-get install -y ffmpeg
RUN  pip install -U moviepy

# install prophet package
RUN pip install -U prophet

# Install tensorFlow and keras
RUN pip install -U tensorflow
RUN pip install -U keras

# Install tensorflow models object detection
RUN git clone https://github.com/tensorflow/models /usr/local/lib/python3.5/dist-packages/tensorflow/models
RUN apt-get install -y protobuf-compiler python-pil python-lxml python-tk

#add dataframe display widget
RUN pip install -U autovizwidget && jupyter nbextension enable --py --sys-prefix widgetsnbextension

#install S3 package
RUN  pip install boto3

#install nosql driver
RUN  pip install pymongo
RUN  pip install elasticsearch 

# Install visualization tools 
RUN  pip install -U seaborn  ggplot plotly prettyplotlib
RUN  pip install -U mplleaflet
RUN  pip install -U pandoc 

# Install web scrapping
RUN  pip install -U bs4

# Install NLP
RUN  pip install -U nltk
RUN  pip install -U gensim
RUN  apt-get install -y aspell-fr  && apt-get install -y enchant 
RUN  pip install stop-words
RUN  pip install pyenchant 
RUN  pip install pyyaml 

# Install pymc 
RUN  pip install -U Theano patsy
RUN  pip install git+https://github.com/pymc-devs/pymc3

# Install xgboost 
RUN  pip install -U xgboost

# Install pattern3 (ie pattern for python3)
RUN pip install --upgrade pillow

#install avro serialization
RUN wget -O /tmp/avro-python3-1.8.2.tar.gz http://apache.mirrors.ovh.net/ftp.apache.org/dist/avro/stable/py3/avro-python3-1.8.2.tar.gz
RUN tar -xvf /tmp/avro-python3-1.8.2.tar.gz -C /tmp/
RUN cd /tmp/avro-python3-1.8.2/ && python3 setup.py install

RUN apt-get install -y graphviz
RUN pip install -U graphviz

#Setting up working directory 
RUN mkdir /lab
WORKDIR /lab

#Minimize image size 
RUN (apt-get autoremove -y; \
     apt-get autoclean -y)

#Set TF object detection available
ENV PYTHONPATH "$PYTHONPATH:/usr/local/lib/python3.5/dist-packages/tensorflow/models/research:/usr/local/lib/python3.5/dist-packages/tensorflow/models/research/slim"
RUN cd /usr/local/lib/python3.5/dist-packages/tensorflow/models/research && protoc object_detection/protos/*.proto --python_out=.

#Setting up ipython notebook server 
EXPOSE 8888 
CMD jupyter notebook --no-browser --ip=0.0.0.0 --port 8888 --allow-root
