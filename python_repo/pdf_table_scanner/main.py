file_url = "https://nift.ac.in/sites/default/files/inline-files/" + \
"Last%20Merit%20Rank-2021.pdf"
import tabula
import numpy as np

# pdf_path = file_url
pdf_path = "sample.pdf"
pageList = list(np.arange(1, 19))
dfs = tabula.read_pdf(pdf_path, pages = pageList)
print(len(dfs))
print(dfs)
