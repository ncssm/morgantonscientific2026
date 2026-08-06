# Generate article PDFs with maybe wrong page numbers
for folder in $( ls -d -1 ../essays/* ../papers/* ../dividers/* ); do
 cd $folder
 myst build --pdf
 cd ../../scripts
done
# Update page numbers in article myst.ymls
bash ./update_pages.sh 5 ../dividers/essays ../essays/* ../dividers/papers ../papers/*
# Re-generate PDFs with correct page numbers
for folder in $( ls -d -1 ../essays/* ../papers/* ../dividers/* ); do
 cd $folder
 myst build --pdf
 cd ../../scripts
done
# Write frontmatter page number summary
bash ./generate_summary.sh ../templates/ncssm-preface/papers.yml ../dividers/essays ../essays/* ../dividers/papers ../papers/*
# Generate frontmatter PDF
cd ../frontmatter
myst build --pdf
cd ../
# Combine all PDFs into final PDF
pdftk frontmatter/article.pdf dividers/essays/divider.pdf essays/*/article.pdf dividers/papers/divider.pdf papers/*/article.pdf cat output morganton2026.pdf
