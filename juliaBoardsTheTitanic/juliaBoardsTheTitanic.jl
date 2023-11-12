using Pkg
Pkg.activate("titanic", shared=true)
using MLJ
using  CSV
import DataFrames as DF

rawDataFolder = "rawData/"
filename = rawDataFolder * "Indian Liver Patient Dataset (ILPD).csv"

header = ["Age", "Gender", "TB", "DB", "Alkphos", "Sgpt", "Sgot", "TP", "ALB", "A/G Ratio"]

df = CSV.File(filename, header=header) |> DF.DataFrame


vscodedisplay(df)
DF.describe(df)
schema(df)
coerce!(df, :sibsp => Count)
schema(df)
df_train, df_test = partition(df, 0.7, rng=123)

yTrain, xTrain = unpack(df_train, ==(:survived), !=(:cabin));
Tree = @load DecisionTreeClassifier pkg=BetaML
tree = Tree()
tree = Tree(max_depth=10)
mach = machine(tree, xTrain, yTrain)
fit!(mach)

pTrain = predict(mach, xTrain)
ŷTrain = mode.(pTrain)
accuracyTrain = accuracy(ŷTrain, yTrain)

yTest, xTest = unpack(df_test, ==(:survived), !=(:cabin));
pTest = predict(mach, xTest)
ŷTest = mode.(pTest)
accuracyTest = accuracy(ŷTest, yTest)

r = range(tree, :max_depth, lower=0, upper=8)

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

pTrain2 = predict(mach2, xTrain);
ŷTrain2 = mode.(pTrain2)
accuracyTrain2 = accuracy(ŷTrain2, yTrain)
pTest2 = predict(mach2, xTest)
ŷTest2 = mode.(pTest2)
accuracyTest2 = accuracy(ŷTest2, yTest)