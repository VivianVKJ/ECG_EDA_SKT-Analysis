import sklearn
import numpy as np
import sklearn.model_selection
from sklearn.metrics import accuracy_score
from sklearn import svm
from sklearn.decomposition import PCA           
import matplotlib.pyplot as plt
from sklearn.svm import LinearSVC
from sklearn import datasets
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression 
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.neighbors import KNeighborsClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn import metrics 
from sklearn.tree import DecisionTreeClassifier
import scipy.io as scio
import pandas as pd
from mpl_toolkits.mplot3d import Axes3D 
from collections import Counter

data_path="forS2.mat"

data = scio.loadmat(data_path)

forS=data['forS']


#x=data,y=group
x, y = np.split(forS, (4,), axis=1)

x = x[:, :4]
x_train, x_test, y_train, y_test = sklearn.model_selection.train_test_split(x, y, random_state=1, train_size=0.7)

y_pd=pd.Series(np.reshape(y,(216,)))
print(y_pd.value_counts())


clf = svm.SVC(C=1, kernel='rbf', gamma=29)
clf.fit(x_train, y_train.ravel())
#
y_hat = clf.predict(x_train)
rxulian=accuracy_score(y_train,y_hat,  '训练集')
print('Train\n',rxulian)
y_hat2 = clf.predict(x_test)
rceshi=accuracy_score(y_test,y_hat2, '测试集')
print('Test\n',rceshi)
#pca=PCA(n_components=3)                           #设置保留的主成分个数为2
#reduced_X=pca.fit_transform(forS);          #调用fit_transform方法，返回新的数据集


# Support Vector Machine
model = svm.SVC()
model.fit(x_train, y_train)
prediction = model.predict(x_test)
print('The accuracy of the SVM is: {0}'.format(metrics.accuracy_score(prediction,y_test)))

# Logistic Regression
model = LogisticRegression()
model.fit(x_train, y_train)
prediction = model.predict(x_test)
print('The accuracy of the Logistic Regression is: {0}'.format(metrics.accuracy_score(prediction,y_test)))


# Decision Tree
model=DecisionTreeClassifier()
model.fit(x_train, y_train)
prediction = model.predict(x_test)
print('The accuracy of the Decision Tree is: {0}'.format(metrics.accuracy_score(prediction,y_test)))


# K-Nearest Neighbours
model=KNeighborsClassifier(n_neighbors=6)
model.fit(x_train, y_train)
prediction = model.predict(x_test)
print('The accuracy of the KNN is: {0}'.format(metrics.accuracy_score(prediction,y_test)))

#Random Forest
model=RandomForestClassifier(max_depth=5, n_estimators=15)
model.fit(x_train, y_train)
prediction = model.predict(x_test)
print('The accuracy of the RandomForest is: {0}'.format(metrics.accuracy_score(prediction,y_test)))

#
#fig = plt.figure()
#ax = fig.add_subplot(111, projection='3d')
#red_x,red_y,red_z=[],[],[]
#blue_x,blue_y,blue_z=[],[],[]
#green_x,green_y,green_z=[],[],[]
#for i in range(len(reduced_X)):
# if y[i]==1:
#     red_x.append(reduced_X[i][0])
#     red_y.append(reduced_X[i][1])
#     red_z.append(reduced_X[i][2])
# elif y[i]==2:
#     blue_x.append(reduced_X[i][0])
#     blue_y.append(reduced_X[i][1])
#     blue_z.append(reduced_X[i][2])
#ax.scatter(red_x,red_y,red_z,c='#ED8428',marker='x');
#ax.scatter(blue_x,blue_y,blue_z,c='#465359',marker='.');
#plt.scatter(green_x,green_y,c='g',marker='.');\
#plt.show()


#red_x,red_y=[],[]
#blue_x,blue_y=[],[]
#green_x,green_y=[],[]
#for i in range(len(reduced_X)):
# if y[i]==1:
#     red_x.append(reduced_X[i][0])
#     red_y.append(reduced_X[i][1])
# elif y[i]==2:
#     blue_x.append(reduced_X[i][0])
#     blue_y.append(reduced_X[i][1])
#plt.scatter(red_x,red_y,c='#ED8428',marker='x');
#plt.scatter(blue_x,blue_y,c='#465359',marker='.');
#plt.rcParams['savefig.dpi'] = 300 #图片像素
#plt.rcParams['figure.dpi'] = 300 #分辨率
#plt.scatter(green_x,green_y,c='g',marker='.');\
#plt.show()
