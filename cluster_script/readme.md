# **Project Title**


## **Vera**

### **Jupyter connect**
```
jupyter notebook --no-browser --port=8888

ssh -N -L localhost:8888:localhost:8888 anwer@vera1.c3se.chalmers.se 
```

### **File Transfer**
```
scp -r /Users/anwer/Desktop/Gene_Regulatory_Network_ROSMAP/code/GRN_Contruction/CERAD_Score anwer@vera2.c3se.chalmers.se:/cephyr/users/anwer/Vera/GRN/
```
## **Singularity**

### **Build**
```
singularity build --fakeroot netzoopy_21_may_24.sif netzoopy.def
```
