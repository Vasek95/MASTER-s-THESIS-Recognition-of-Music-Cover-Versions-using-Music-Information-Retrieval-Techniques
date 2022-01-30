
function normalized_matrix = normalizeMatrix(feat_matrix)

normalized_matrix = zeros(size(feat_matrix,1),size(feat_matrix,2));

for i = 1:size(feat_matrix,2)
   
    currentFeat = feat_matrix(:,i);
    currentFeat = (currentFeat - mean(currentFeat)) / std(currentFeat);
  
    normalized_matrix(:,i) = currentFeat;
    
end    