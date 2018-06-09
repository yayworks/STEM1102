
#!/bin/bash

export PYTHONPATH=/usr/local/anaconda3/envs/tensorflow/lib/python3.6:/usr/local/anaconda3/envs/tensorflow/lib/python3.6/site-packages/:/usr/local/anaconda3/envs/tensorflow/lib/python3.6/site-packages/prettytensor-0.7.2-py3.6.egg:/usr/local/anaconda3/envs/tensorflow/lib/python3.6/site-packages/enum34-1.1.6-py3.6.egg:/usr/local/anaconda3/envs/tensorflow/lib/python3.6/site-packages/setuptools-27.2.0-py3.6.egg:/usr/local/anaconda3/envs/tensorflow/lib/python3.6/site-packages/matplotlib:
source /usr/local/anaconda3/bin/activate tensorflow

app_name="JupyterLab"
port=$1

token=`cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 48 | head -n 1`

/usr/local/anaconda3/bin/jupyter lab --ip=0.0.0.0 --port=$port --LabApp.token=$token &

out_str=${app_name}:${port}/?token=${token}

echo ${out_str} >> /home/nimbix/.tokens.list
~                                                   
