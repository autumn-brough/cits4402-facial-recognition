




%Source working directory containing s1 to s40 subdirectories where the source pgm image files
%are stored
FaceDataset = 'FaceDataset';
%Destination working direction containing person1 to person40 subdirectories where test image
%set are stored
TestingDataset = 'TestingDataset';
%Destination working direction containing person1 to person40 subdirectories where training image
%set are stored
TrainingDataset= 'TrainingDataset';









SubDirInTrainingDataset= dir(TrainingDataset);
idxSubDir = [SubDirInTrainingDataset.isdir] & ~strcmp({SubDirInTrainingDataset.name},'.') & ~strcmp({SubDirInTrainingDataset.name},'..');
%Folders for each face in TrainingDataset
TrainingDatasetFolders = {SubDirInTrainingDataset(idxSubDir).name};
NumTrainingDatasetFolders = size(TrainingDatasetFolders, 2);

%Allocation of zeros for a 4 dimensional matrix representing all the training class specific
%models of the images. The first index is the number of row which in this case is the height
%of the column vector created from the images.5 is the number of images in the Person director
%NumTrainingDatasetFolders is the number of the class specific models
X= zeros(10304, 7, NumTrainingDatasetFolders);
%X_resized = zeros(handles.ResizedImageWidth * handles.ResizedImageWidth, 5, NumTrainingDatasetFolders);
%Give the whose set of class specific models so it can be access in all of the gui*

%Loop through Training face subdirectories
for i= 1:numel(TrainingDatasetFolders)
    P = fullfile(TrainingDataset,TrainingDatasetFolders{i});
    %Image files in TrainingDataset/TrainingDatasetFolders
    D = dir(fullfile(TrainingDataset,TrainingDatasetFolders{i},'*.pgm'));
    C= cell(size(D));
    
    %Set up a storage matrix which will have column image vectors appended to it
    X_i = [];
    
    
    %Loop through images in Person subdirecties in directory
    for j = 1:numel(D)
        
        %read the image file in the directory
        C{j} = imread(fullfile(P,D(j).name));
        
        %Create a column vector from the image read
        imgVector = C{j}(:);
        %Normalize the vector by converting it to double and dividing by its norm
        imgVector = double(imgVector);
        imgVector= imgVector/norm(imgVector);
        
        %Append the image column vector to the storage matrix
        X_i= [X_i imgVector];
        
    end
    
    
    %If the number of images in the subdirectory is not equal to 0
    if numel(D) ~= 0
        
        %Assign the ith class specific model the dummy matrix
        X(:,:,i) = X_i;
    end
    
end

"Model trained!"





SubDirInTestingDataset= dir(TestingDataset);
idxSubDir = [SubDirInTestingDataset.isdir] & ~strcmp({SubDirInTestingDataset.name},'.') & ~strcmp({SubDirInTestingDataset.name},'..');
%Folders for each face in TestingDataset
TestingDatasetFolders = {SubDirInTestingDataset(idxSubDir).name};
NumTestingDatasetFolders = size(TestingDatasetFolders, 2);

%Loop through Testing face subdirectories
for i= 1:numel(TestingDatasetFolders)
    P = fullfile(TestingDataset,TestingDatasetFolders{i});
    %Image files in TestingDataset/TestingDatasetFolders
    D = dir(fullfile(TestingDataset,TestingDatasetFolders{i},'*.pgm'));
    C= cell(size(D));
    
    %Loop through images in Person subdirecties in directory
    for j = 1:numel(D)
        
        test_for_nearest_match(fullfile(P,D(j).name), X, TrainingDataset, TrainingDatasetFolders, NumTrainingDatasetFolders);
        
    end
    
end














% --- Executes on button press in Test_for_face_with_nearest_match.
function test_for_nearest_match(img_name, X, TrainingDataset, TrainingDatasetFolders, NumTrainingDatasetFolders)

%Get image selected
image_opened= imread(img_name);
%Convert to a column vector
imgVectorTest = image_opened(:);
%Convert to a double vector
imgVectorTest = double(imgVectorTest);
%Norm The vector
imgVectorTest = imgVectorTest/norm(imgVectorTest);

minDist = Inf;
%Loop through all Person subfolders ignoring . and ..
for i= 1:NumTrainingDatasetFolders
    
    %summon up the ith class specific model
    Xi= X(:,:,i);
    
    %Do the computaions on the it specific model and and column vector of the image chosen
    %to get a Euclidian measure of distance from the image chosen
    yi = Xi/(Xi.'*Xi)*Xi.'*imgVectorTest;
    distances = sqrt((yi - imgVectorTest).^2);
    dist = sum(distances);
    
    %If distance is less then store i as index of nearest face
    if dist < minDist
        minDist = dist;
        indexNearestFace = i;
    end
end

%Get directory where nearest face is held
P = fullfile(TrainingDataset,TrainingDatasetFolders{indexNearestFace});
D = dir(fullfile(TrainingDataset,TrainingDatasetFolders{indexNearestFace},'*.pgm'));

%Display nearest face
disp("matched " + img_name + " with " + P)
end










