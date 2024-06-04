# **Project Title**

## **Ensemble ID to Gene Name**
```
# Example how to use ensemble_name_to_gene.py
import ensemble_name_to_gene.return_gene_name as return_gene_name
important_TF_0_1 = ['ENSG00000162992',
 'ENSG00000118620',
 'ENSG00000168874',
 'ENSG00000092607',
 'ENSG00000177485',
 'ENSG00000196705',
 'ENSG00000198429',
 'ENSG00000254004',
 'ENSG00000137492',
 'ENSG00000177873']
filtered_gene_set_0_1 = [return_gene_name(i)[0] for i in important_TF_0_1]
filtered_gene_set_0_1
```
