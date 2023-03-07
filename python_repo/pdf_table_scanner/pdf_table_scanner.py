file_url = "https://nift.ac.in/sites/default/files/inline-files/" + \
"Last%20Merit%20Rank-2021.pdf"
import tabula
import numpy as np

# pdf_path = file_url
pdf_path = "sample.pdf"
# pages = np.arange(1,18)
dfs = tabula.read_pdf(pdf_path, pages = '1')
print(len(dfs))
print(dfs[0])
