from biomart import BiomartServer

server = BiomartServer("http://www.ensembl.org/biomart")

def return_gene_name(ensemble_id):

# Connect to the Ensembl Biomart server
    
    
    # Select the appropriate dataset (human genes in this case)
    dataset = server.datasets['hsapiens_gene_ensembl']
    
    # List of Ensembl IDs to convert
    ensembl_ids = ensemble_id # Add your IDs here
        
        # Perform the query to get the gene symbols
    response = dataset.search({
            'filters': {
                'ensembl_gene_id': ensembl_ids,
            },
            'attributes': [
                'ensembl_gene_id',
                'external_gene_name',
            ]
        })
        
        # Process and display the results
    result = []    
    for line in response.iter_lines():
        decoded_line = line.decode('utf-8')
        ensembl_id, gene_symbol = decoded_line.split('\t')
        result.append(gene_symbol)
    return result




'''
Use Case Example:

in new python file

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


'''