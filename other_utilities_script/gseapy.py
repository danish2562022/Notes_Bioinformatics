import gseapy as gp
from gseapy import Msigdb
from gseapy import barplot, dotplot
import ensemble_name_to_gene.return_gene_name as return_gene_name


# Function to return enriched pathways based on a filtered gene set
def return_enriched_pathways(filtered_gene_set, adj_p_value = 0.05, gene_sets_databases =['GO_Molecular_Function_2023']):
    enr = gp.enrichr(gene_list= filtered_gene_set, gene_sets=gene_sets_databases, organism='human')
    
    dataframe = enr.results[enr.results['Adjusted P-value']<adj_p_value].sort_values(by = 'Adjusted P-value')
    return dataframe

# Function to plot a dot plot of the enriched pathways
def plot_dotplot(dataframe,size=10,top_term=5,fig_size=(3,5),title="GSEA"):
    ax = dotplot(dataframe,
              column="Adjusted P-value",
              x='Gene_set', # set x axis, so you could do a multi-sample/library comparsion
              size=size,
              top_term=top_term,
              figsize=fig_size,
              title = title,
              xticklabels_rot=45, # rotate xtick labels
              show_ring=True, # set to False to revmove outer ring
              marker='o',
             )

# Function to plot a bar plot of the enriched pathways
def plot_barplot(dataframe,size=10,top_term=5,fig_size=(3,5),title="GSEA"):
    ax = barplot(dataframe,
                  column="Adjusted P-value",
                  group='Gene_set', # set group, so you could do a multi-sample/library comparsion
                  size=size,
                  title=title,
                  top_term=top_term,
                  figsize=fig_size,
                  #color=['darkred', 'darkblue'] # set colors for group
                  #color = {'KEGG_2021_Human': 'salmon', 'MSigDB_Hallmark_2020':'darkblue'}




# List of gene set databases to be used for enrichment analysis
databases = ['WikiPathway_2023_Human', 'Reactome_2022', 'OMIM_Disease', 'KEGG_2021_Human', 'GO_Molecular_Function_2023', 'GO_Cellular_Component_2023',
             'GO_Biological_Process_2023', 'DisGeNET', 'Allen_Brain_Atlas_10x_scRNA_2021']


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

# Iterate over each gene set database and perform enrichment analysis for different filtered gene sets
for i in databases:
    dataframe_tf_0_1= return_enriched_pathways(filtered_tf_set_0_1, adj_p_value = 0.05, gene_sets_databases =[i])

    # Plot the results for each gene set comparison
    try:
        plot_dotplot(dataframe_tf_0_1,size=10,top_term=5,fig_size=(3,5), title=str(i)+'_'+'_0_1')
        plot_barplot(dataframe_tf_0_1,size=10,top_term=5,fig_size=(3,5), title=str(i)+'_'+'_0_1')
    except:
        print('No significant results for', i, '_0_1')






