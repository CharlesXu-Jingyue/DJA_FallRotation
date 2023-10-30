# GLM-HHM Pipeline

Charles Xu @ DJA Lab, Caltech</br>
20231006

## Preprocessing

The first step is preprocessing the annotation data and neural activity data. This includes Gaussian smoothing the neural data, and transforming and downsampling the annotation data.

Code is adapted from previous code in the lab in MATLAB into Python.

## Design Matrix

Once the data has been preprocessed, the next step is to create a design matrix. Conceptually, the design matrix is constructed based on $X\beta = Y$, Where $X$ is the behaviour or task (explanatory) variable (our design matrix), $\beta$ is the weights, and $Y$ is the neural activity for a linear encoder. $Y$ should have size $[n\_samples \times n\_neurons]$.

The design matrix $X$ has size $[n\_samples \times n\_regressors]$

## Model Fitting/Training

GLM-HMM could take discrete/continuous hidden states depending on the experiment and research question. In a GLM-HMM, both the output observation probability and the state transition probability are parameterized by GLM. The specific GLM to use is determined depending on the distribution (family) of the predicted variable.

Fitting the GLM-HMM model involves the EM optimization, where the E-step estimates a posterior for the given data and parameters, and the M-step maximizes the expected log-likelihood. Additionally, a regularization penalty term can be added to avoid overfitting.

Questions
- Is EM computed for each hidden state?
- When to use discrete vs continuous HMM?
- What regression for GLM? (logistic vs multinomial logistic: 2 vs more predictions?)
