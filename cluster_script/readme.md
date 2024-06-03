# **Project Title**


## **Vera**

### **Jupyter connect**
```
jupyter notebook --no-browser --port=8888

ssh -N -L localhost:8888:localhost:8888 anwer@vera1.c3se.chalmers.se 
```

### **Jupyter connect from computing node**

1) Connect to Alvis:
    ```
	ssh user-name@alvis2.c3se.chalmers.se
    ```
1a) Make a directory for your project:
```
	cd /cephyr/users/user-name/Alvis
	mkdir virus_evolution
```

2) Copy your scripts from OX to Alvis:
```
	from local_machine: scp -r /vault/jeehae/src/Transformers user-name@alvis2.c3se.chalmers.se:/cephyr/users/user-name/Alvis/virus_evolution
```
3) Check that everything is moved to Alvis


4) Start an interactive session on Alvis as follows:

```
	srun -A NAISS2023-5-248 -N 1 -t 10:00:00 --gpus-per-node=A100:1 --pty bash
```

	The command above will give you one GPU A100 for 10hours. (use A40 instead because it's cheaper, unless you cannot get it, usually A40s are busy).

5) Wait a little until you get allocated a slot. Once you get the resources you need to add the following modules:

	Firstly, once you get resources, notice that your terminal will change to something like this: [user-name@alvisX-X ~]$  (take a note of this part: alvisX-X, this will be your node for the next 10h)
```
	Issue the following commands:

	module load TensorFlow/2.11.0-foss-2022a-CUDA-11.7.0
	module load JupyterLab
	module load matplotlib/3.5.2-foss-2022a
```

6) We need to start Jupyter notebook, issue this:
```
	jupyter notebook
```

7) See carefully what is printed out from jupyter. You need to find out 1) the port and 2) the token. It will output in the end something like this:

```
	http://localhost:8888/?token=ba1b550becbc0821f047e5641b36bcfd508cb7bb23ec02f
```
	port here is 8888, and token here is ba1b550becbc0821f047e5641b36bcfd508cb7bb23ec02f 


8) We need to forward information from your node to alvis, and then, forward it to your computer:

	8a) Node to Alvis: 

	open new terminal from your computer and connect to alvis, then do this: ssh -L 8888:localhost:8888 user-name@alvisX-X

	8b) Alvis to your computer:

	open a new terminal from your computer and do:
    ```
	ssh -L 6543:localhost:8888 user-name@alvis2.c3se.chalmers.se (6543 is an arbitrary port that you can change)
    ```
9) Get Jupyter notebook on your screen:

	open a new tab on your browser and do this:
	http://localhost:6543/ 

	it will ask for token, put the token from above to connect.

	browse to your directory where is your .ipynb and start it.


INFO: You need to be in Chalmers network for this work. You can try it at home if you want, but you have to ssh to Alvis via OX and open an aditional port to your local machine (basicaly repeat 8b with correct ports)

Credit for this: Nikolaos Tatrakis https://www.sysbio.se/people/nikolaos-tatarakis/ 









### **File Transfer**
```
scp -r /Users/anwer/Desktop/Gene_Regulatory_Network_ROSMAP/code/GRN_Contruction/CERAD_Score anwer@vera2.c3se.chalmers.se:/cephyr/users/anwer/Vera/GRN/
```
## **Singularity**

### **Build**
```
singularity build --fakeroot netzoopy_21_may_24.sif netzoopy.def
```
