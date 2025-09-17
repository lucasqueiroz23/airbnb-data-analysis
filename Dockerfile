FROM jupyter/datascience-notebook

WORKDIR /home/project

COPY . /home/project

RUN pip install -r requirements.txt

EXPOSE 8888

RUN jupyter execute ./raw/analytics.ipynb

CMD ["bash", "execute-scripts.sh"]
