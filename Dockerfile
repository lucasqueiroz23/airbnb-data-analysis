FROM jupyter/datascience-notebook

WORKDIR /home/project

COPY . /home/project

RUN pip install -r requirements.txt

EXPOSE 8888

CMD ["bash", "execute-scripts.sh"]
