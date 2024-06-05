import os
import pickle as pkl

import pandas as pd

from pydeseq2.dds import DeseqDataSet
from pydeseq2.default_inference import DefaultInference
from pydeseq2.ds import DeseqStats



def differential_expression_analysis(output_dir, count_matrix, meta_data):

    inference = DefaultInference(n_cpus=8)
    dds = DeseqDataSet(
        counts=count_matrix,
        metadata=meta_data,
        design_factors="condition",
        refit_cooks=True,
        inference=inference,
    )

    dds.deseq2()

    print(dds)
    print(dds.varm["dispersions"])
    print(dds.varm["LFC"])

    stat_res = DeseqStats(dds, inference=inference)
    print(stat_res.summary())
    stat_res.results_df.to_csv(os.path.join(output_dir, "results.csv"))



count_matrix = pd.read_csv('test_counts.csv',index_col=0).T
meta_data = pd.read_csv('test_metadata.csv',index_col=0)
print(count_matrix)
print(meta_data)

differential_expression_analysis(output_dir='./different_expression_output/', count_matrix=count_matrix, meta_data=meta_data)