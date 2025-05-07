---
documentclass: article
classoption: twocolumn
---
# Lecture 05: Weak Stochastic Realisation of Gaussian Systems - I

## Motivation and Problem Definition
### Motivating Example
Given that we measured an output process, how do we obtain a time-invariant Gaussian system of the form? There are 2 main problems:

- System Identification, find _approximate_ system parameters based on measurements
- Stochastic Realisation, Find an _exact_ representation of a Gaussian system based on a covariance function

\fbox{\parbox{\columnwidth}{
\textbf{Example \textnormal{(Paper Machine Realisation)}.}
Consider observations without inputs and compute
$$
\{z(s) \in \R^{n_{y}}, \forall t\in T_{1} = \{1, 2, , \cdots , t_{1}\}\}
$$
Where we estimate the average of the series as
$$
z_{a} = \frac{1}{t_{1}} \sum_{s=1}^{t_{1}-1}z(s)
$$
we can then make an estimate of the covariance function such that 
$$
\hat W(t) = \frac{1}{(t_{1}-t)-1} \sum_{s=1}^{t_{1}-t} (z(t+s) - z_{a})(z(s)-z_{a})^{T}
$$
The function $\hat W$ is a covariance function if and only if it is PD function and if and only if it satisfies a block Toeplitz matrix condition for all times. We now want a representation of the form
\begin{align*}
    x(t+1) &= Ax(t) + Mv(t), x(0) = x_{0} \in G(0, Q_{x})\\
    y(t) &= Cx(t) + Nv(t), v(t) \in G(0, I_{n_{v}})\\
    *\text{spec}(A) \subset \mathbb{D}_{o},\\
    Q_{x} &= AQ_{x}A^{T} + MM^{T}
\end{align*}
The probability measure associated with ouput $y$ is equal to the probability measure associated with the stochastic process obtained from the measurements.
}}


### Problem Definition
_Problem (Weak Gaussian Stochastic Realisation Problem_: Consider a stationary Gaussian process taking values in measurable space $(\R^{n_{y}}, B(\R^{n_{y}}))$, $m(t) = 0$ for all $t\in T$ and with covariance function $W: T\to \R^{n_{y}\times n_{y}}$.
\begin{enumerate}
    \item[(a)] Does there exists a stable time invariant Gaussian system representation?
    \item[(b)] Characterize weak Gaussian stochastic realisation which are of minimal state-space dimension
    \item[(c)] Classify or describe all weak Gaussian stochastic realisation of the considered process. Relate any two minimal weak stochastic realisation to one another
    \item[(d)] Formulate a procedure by which one of can construct all weak Gaussian Stochastic Realisations
\end{enumerate}


## Stochastic Realisation Theory
Consider the covariance function of a stationary process $W: T \to \R^{n_{y} \times n_{y}}$ on $T = \mathbb{N}$. Define the finite Hankel matrix of $W$ with $k$ row block and $m$ column blocks as
\small
\begin{gather*}
H_{w}(k, m) =\\
\begin{bmatrix}
    W(1) & W(2) & \cdots & W(m-1) & W(m)\\
    W(2) & W(3) & \cdots & W(m) & W(m+1)\\
    W(3) & W(4) & \cdots & W(m+1) & W(m+2)\\
    \vdots & \vdots & \ddots & \vdots & \vdots\\
    W(k) & W(k+1) & \cdots & W(k+m-2) & W(k+m-1)\\
\end{bmatrix}
\end{gather*}
We can extend this to an infinite Hankel matrix which leads to the following: Define 
$$
\rank(H_{W}) = \sup_{k, m}\; \rank(H_{W}(k,m))
$$
Where $H_{w}$ is  finite rank if the rank above is not infinite for the infinite Hankel matrix. This is a theoretical condition.

We define a set of state variance matrices associated with a  parameterization of a covariance function by the formula
$$
\begin{bmatrix}
    Q - FQF^{T} & G-FQH^{T}\\
    (G 0 FQH^{T})^{T} & J + J^{T} - HQH^{T}
\end{bmatrix} \succeq 0
$$
Which is an LMI on $Q$.

The weak Gaussian stochastic realisation and assume that 
$$
T = \mathbb{Z}, m(t) = 0, W(0) \succ 0, \lim_{t\to \infty} W(t) = 0
$$
There exists a time-invariant Gaussian system representation such that the output process $y$ equal the considered process in probability; equivalently if 
$$
w(t) = W_{y}(t) \quad \forall t \in T \iff \rank(H_W) < \infty
$$
Note that the rank of the infinite Hankel matrix is in fact equal to the minimal dimension of the state space realisation of the process. Call this system a weak Gaussian Stochastic realisation. for any weak Gaussian realisation there exists some state variance $Q_{x}\in \mathbb{Q}_{lsdp}$. If a weak realiastion, then there exists a covariance function of the form 
$$
W(t) = \begin{cases}
HF^{t-1}G \quad t > 0\\
J + J^{T} \quad t = 0\\
(HF^{t-1}G)^{T} \quad t < 0
\end{cases}
$$
A weak Gaussian stochastic realisation with $\text{spec}(A) \subset \mathbb{D}_{o}$ is of minimal dimension over all such realisations if and only if the following holds
:

- Support of the Gaussian measure $G(0, Q_{x})$ of the state process equal $\R^{n_{x}}$ ($Q_{x} \succ 0$ iff $(A, M) \text{ Supportable }$)
- If the system is stochastically observable
- If the system is stochastically co-observable

We now want to classify the description. Fix a covariance relation. Define the classification map as the function 
$$
c_{lsp}: Q_{lsdp} \to \text{WGSRP}_{\min} \text{ is a bijection}
$$
We write
$$
\begin{bmatrix}
    M\\ N
\end{bmatrix} \begin{bmatrix}
    M & N
\end{bmatrix} = 
\begin{bmatrix}
    Q - FQF^{T} & G-FQH^{T}\\
    (G 0 FQH^{T})^{T} & J + J^{T} - HQH^{T}
\end{bmatrix}
$$
Stochastic realiations have a unique minimal element and a unique maximal element.
$$
\exists Q^{-}, Q^{+} \in Q_{lsdp}, \forall Q \in Q_{lsdp}: Q^{-}\preceq Q \preceq Q^{+}
$$

We also want to classify the realisation as minimal. We relate 2 realisation by a linear map:
\begin{align*}
A_{1} &= L_{x}A_{2}L_{x}^{-1}\\
C_{1} &= C_{2}L_{x}^{-1}\\
M_{1} &= L_{x}M_{2}U_{v}\\
N_{1} &= N_{2}U_{v}
\end{align*}
The realisation is minimal if it is a linear transformation of a minimal realisation.
The realisation can be considered minimal if we take $(F, G)$ controllable and $(H, J)$ observable.


\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Weak Gaussian Stochastic Realisation)}.}\textit{
Consider a stationary Gaussian process with zero mean value function and with covariance function $W$. Determine a minimal covariance realisation of $W$ such
$$
W(t) = \begin{cases}
HF^{t-1}G\quad t > 0\\
J + J^{T} \quad t = 0\\
G^{T}(F^{T})^{-t-1}H^{T} \quad t < 0
\end{cases}
$$
Determine a matrix $Q \in Q_{lsdp}$ which implies that $Q \in \R_{pds}^{n_{x}\times n_{x}}$ where $n_{x}$ is the rank of the infinite Hankel matrix. Then construct $A = F$, $C = H$ and $n_{v} = n_{x} + n_{y}$, $M\in \R^{n_{x}\times n_{v}}$ and $N \in \R^{n_{y} \times n_{v}}$ such that 
\small
$$
\begin{bmatrix}
    M \\ N
\end{bmatrix}
\begin{bmatrix}
    M & N
\end{bmatrix} ^T = \begin{bmatrix}
    Q - FQF^{T} & G - FQH^{T}\\
    (G - FQH^{T})^{T} & J + J^{T} - HQH^{T}
\end{bmatrix} \succeq 0
$$
\normalsize
$\Omega = \R^{n_x} \times (\R^{n_{v}})^{T}$, $\omega = (\omega_{1}, \omega_{2})$ such that $x_{0}(\omega) = \omega_{1}$, $v(\omega, t) = \omega_{2}(t)$ such that $x_{0} \in G(0, Q)$, $v(t) \in G(0, I_{n_{v}})$, $F^{x_{0}}, F^{v}_{\infty}$ independent then 
$$
(n_{y}, n_{x}, n_{v}, A, C, M, N) \in \text{WGSRP}_{\min}
$$
}}}


### Kalman Realisation and the Kalman Filter
The Kalman realization is a time-invariant Gaussian system such that 

- $(A, M)$ is supportable pair ($Q_{x} \succ 0$)
- $(A, C)$ is observable pair
- $(A_{b}, C_{b})$ is observable pair (co-observability)
- $\text{spec}(A - MN^{-1}C) \subset \mathbb{D}_{o}$


Consider a Kalman realisation and define 
$$
Q_{x} = AQ_{x}A^{T} +MM^{T}
$$
then $Q_{x} \succ 0$and $Q_{x} = Q^{-} \in Q_{lsdp}(F, G, H, J)$. The state variance matrix $Q_{x}$ of the Kalman realisation equal the minimal state variance. Kalman realised that any Kalman realisation can be written as the Kalman filter linear system
$$
\begin{cases}
x(t+1) &= Ax(t) + MN^{-1}[y(t) - Cx(t)]\\
v(t) &= N^{-1}[y(t) - Cx(t)]
\end{cases}
$$
Where we note that $MN^{-1}$ is the Kalman gain. Note also that $F^{x(t+1)} \subseteq F_{t}^{y-} \vee F^{x_{0}}$.


### Explanation of Minimality
Consider that if we have that $(A, M)$ not supportable pair. In the long run $x_{2}$ is irrelevant, implying that $Q_{x}\nsucc 0$ and hence it cannot be minimal. 

In the case that $(A, C)$ is not observable there are components of $x$ that do not show up in $y$. Thus we do not have that these states are relevant for the input-output behaviour and hence we can disregard the states.

Be careful about the following false conjecture:

- $(A, M)$ is supportable
- $(A, C)$ is stochastically observable
- These 2 facts together do NOT imply minimal weak Gaussian realisation of the output process. We also NEED co-observability


The Kalman filter is another Stochastic Realisation. Consider the time invariant Kalamn filter of time invariant Gaussian system
\begin{gather*}
\hat x(t+1) = A\hat x(t) + K[y(t) - C\hat x(t)]\\
\bar v(t) = y(t) - C\hat x(t) \quad v(t) \in G(0, Q_{\bar v})
\end{gather*}
hence 
\begin{gather*}
\hat x(t+1) = A\hat x(t) + K\bar v(t)\\
y(t) = C\hat x(t) + \bar v(t)
\end{gather*}
Note that these 2 representations are two stochastic realisations of the same output process $y$. The Kalman filter is also a weak Gaussian stochastic realisation.

We can transform system to a minimal realisation. We start with $(n_{y}, n_{x}, n_{v}, A, C, M, N) \in \text{WGSRP}$ and we assume $A$ Schur stable. Suppose that $(A, M)$ is not a supportable pair. Then transform the system to the Kalman form:
$$
x(t+1) = \begin{bmatrix}
    A_{11} & A_{12}\\
    0 & A_{22}\\
\end{bmatrix}x(t) + \begin{bmatrix}
    M_{1}\\0
\end{bmatrix}v(t)
$$
Then $(A_{11}, M_{1})$ with corresponding $C_{1}$ and $N$ is a reduced order representation. This again holds for $(A, C)$ not observable. Then there exists a Kalman decomposition such that 
\begin{align*}
x(t+1) &= \begin{bmatrix}
    A_{11} & 0\\
    A_{21} & A_{22}\\
\end{bmatrix}x(t) + \begin{bmatrix}
    M_{1}\\M_2
\end{bmatrix}v(t)\\
y(t) &= \begin{bmatrix}
    C_{1} & 0
\end{bmatrix}x(t) + Nv(t)
\end{align*}
Where the pair $(A_{11}, C_{1})$ is observable and the representation 
\begin{align*}
    x(t+1) &= A_{11}x(t) + M_{1}v(t)\\
    y(t) &= C_{1}x(t) + Nv(t)
\end{align*}
is again of lower dimension. Finally, we can also do this for the backward representation for co-observability. After all 3 steps the realisation will always be minimal.

### Strong Stochastic Realisation of Gaussian Process
Consider stationary stochastic process $\bar y$. Call a Gaussian system a strong Gaussian stochastic realisation of $\bar y$ if there exists a time invariant Gaussian system such that 
$$
(x, y) \text{ and } F^{x(t)} \subseteq F^{y}_{\infty}
$$
such that $\bar y = y$ almost surely for all $t$. To construct a strong realisation in the $\sigma$-algebraic setting. Construct $x(t) \in X$ such that 
$$
(F^{y+}_{t}, F^{y-}_{t-1}|F^{x(t)}) \in CI
$$
We have $F^{x(t)}\subseteq F^{y-}_{t-1}$. Paricular case $y_{+},y_{-}$ are jointly Gaussian finite dimensional vectors.
$$
x = \mathbb{E}\left[y_{+}|F^{y_{-}}\right] = Q_{y_{}{+}y_{-}}Q^{-1}y_{-}
$$
Note that $(F^{y+}_{t}, F^{y-}_{t-1}|F^{x(t)}) \in CI$ then $(x, y)$ are state and output process of a stochastic system.

## System Identification
Original motivation of Kalman to research stochastic realisation was system identification. For a system to be identifiable we need a characterization of minimality and the description of the equivalence class of stochastic realisation. A procedure to determine an approximat eweak stochastic realisation called the subspace identification algorithm. Construct of a canonical form is needed. For example Observable canonical form.

Consider stationary Gaussian process on a finite horizon

1. Fix time $t_{0} \in T$. Restrict attention to finite future and past. Construct
\begin{align*}
F^{y-}_{t_{0}-1} &\implies y_{-}(t_{0}-t:t_{0}-1)\\
F^{y+}_{t_{0}} &\implies y_{+}(t_{0}-t:t_{0}+t_{1}-1)
\end{align*}
We have $(y_{+}, y_{-}) \in G$ and 
$$
x(t_{0}) = \mathbb{E}\left[y_{+} | F^{y_{-}}\right] = Ly_{-}(t_{0}-t_{1}:t_{0}-1
$$
using $\hat W$ then $(F^{y+}, F^{y-}| F^{x(t_{0})}) \in CI$. We compute
$$
x(t_{0} + 1) = Ly_{-}(t_{0}-t_{1}+1:t_{0})
$$

2. Construct the system matrices and the noise porcess.
\begin{gather*}
(x(t_{0}), x(t_{0} + 1), y(t_{0})) \in G \implies\\
\begin{bmatrix}
    A\\ C
\end{bmatrix} x(t_{0}) = \mathbb{E}\left[
\left.
\begin{bmatrix}
    x(t_{0}+1)\\ y(t_{0})
\end{bmatrix}  
\right| F^{x(t_{0})}
\right]
\end{gather*}
where $v: \Omega \times T \to \R^{n_{x} + n_{y}}$ Gaussian white noise. We have
\begin{align*}
    v(t) &= \begin{bmatrix}
        x(t+1) - Ax(t)\\
        y(t) - Cx(t)
    \end{bmatrix} \in G(0, Q_{v})\\
    M &= \begin{bmatrix}
        I_{n_{x}} & 0
    \end{bmatrix}, N = \begin{bmatrix}
        0 & I_{n_{y}}
    \end{bmatrix}
\end{align*}

3. One obtains a Gaussian system representation with output process $y(t)$ which is an approximation of the Gaussian process.


