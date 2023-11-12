using Pkg
Pkg.activate("titanic", shared=true)
using MLJ
using  CSV
import DataFrames as DF

rawDataFolder = "rawData/";
filename = rawDataFolder * "Indian Liver Patient Dataset (ILPD).csv";

header = ["Age", "Gender", "TB", "DB", "Alkphos", "Sgpt", "Sgot", "TP", "ALB", "A/G Ratio", "Diagnosis"];

df00 = CSV.File(filename, header=header) |> DF.DataFrame;


# vscodedisplay(df0)



df0 = DF.dropmissing(df00);

df = deepcopy(df0);
# Convert "Gender" to 0 and 1
df.Gender = map(gender -> gender == "Male" ? 0 : 1, df.Gender);

# Convert "Diagnosis" from 1 to 1/3 and 2 to 2/3
df.Diagnosis = map(diagnosis -> diagnosis == 1 ? 1/3 : 2/3, df.Diagnosis);

# Normalize the first 10 columns
for col in names(df)[1:10]  # Adjust the 10 here if the number of columns to normalize changes
    min_val, max_val = minimum(df[!, col]), maximum(df[!, col]);
    df[!, col] = map(x -> (x - min_val) / (max_val - min_val), df[!, col]);
end

# DF.describe(df)

schema(df)

df1 = deepcopy(df);
df1.Diagnosis = map(diagnosis -> diagnosis == 1 ? 0 : 1, df0.Diagnosis);
coerce!(df1, :Gender => Multiclass);
coerce!(df1, :Diagnosis => Multiclass)

# vscodedisplay(df)

df_train, df_test = partition(df1, 0.7, rng=123);

yTrain, xTrain = unpack(df_train, ==(:Diagnosis));
models(matching(xTrain, yTrain))

Tree = @load DecisionTreeClassifier pkg=BetaML
# Tree = @load ConstantClassifier pkg = MLJModels
tree = Tree()
# tree = Tree(max_depth=12)
mach = machine(tree, xTrain, yTrain)
fit!(mach)

pTrain = predict(mach, xTrain)
ŷTrain = mode.(pTrain)
accuracyTrain = accuracy(ŷTrain, yTrain)

yTest, xTest = unpack(df_test, ==(:Diagnosis));
pTest = predict(mach, xTest);
ŷTest = mode.(pTest)
accuracyTest = accuracy(ŷTest, yTest)

r = range(tree, :max_depth, lower=0, upper=8);

tuned_tree = TunedModel(
    tree,
    tuning = Grid(),
    range=r,
    measure = accuracy,
    resampling=Holdout(fraction_train=0.7),
)

mach2 = machine(tuned_tree, xTrain, yTrain)
fit!(mach2)

fitted_params(mach2).best_model

pTrain2 = predict(mach2, xTrain)
ŷTrain2 = mode.(pTrain2)
accuracyTrain2 = accuracy(ŷTrain2, yTrain)
pTest2 = predict(mach2, xTest)
ŷTest2 = mode.(pTest2)
accuracyTest2 = accuracy(ŷTest2, yTest)