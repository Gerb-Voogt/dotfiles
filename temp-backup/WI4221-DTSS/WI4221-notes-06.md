---
documentclass: article
classoption: twocolumn
---

# Lecture 06: Weak Stochastic Realisation of Gaussian Systems - II


## Realisation of Deterministic Linear Systems
\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Impulse Response Function)}.}\textit{
Define the impulse response function of LTI system according to 
\begin{align*}
x(t+1) &= Ax(t) + Bu(t), \quad x(0) = x_{0}\\
y(t) &= Cx(t) + Du(t),\\
W_{s}(t) &= \begin{cases}
D, \quad t = 0\\
CA^{t-1}B, \quad t \geq 1
\end{cases}
\end{align*}
Where we can define the input as a unit impulse $\delta(t)$ and the output is given in terms of convolution sum of the impulse response and input.
}}}

Consider an impulse response function $W: \mathbb{N}\to \R^{n_{y}\times n_{u}}$ If there exists an LTI system $(n_{y}, n_{x}, n_{u}, A, B, C, D) \in LSP$ such that $W(t) = W_{s}(t)$ where $W_{s}(t)$ defined above then we call this system a realisation. The realisation is minimal if $x(t)$ is of minimal dimensions.

The realisation construct an internal description based on an external description:

- **External**: input-output behaviour of a linear system $(n_{y}, n_{u}, W)$
- **Internal**: input-output behaviour of a linear system $(n_{y}, n_{x}, n_{u}, A, B, C, D)$

Needed to quantify minimality:
$$
\rank(\mathcal{C}(A, B)) = n_{x}, \qquad
\rank(\mathcal{O}(A, C)) = n_{x},
$$


\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Existence of a Realisation (Kalman, 1963))}.}\textit{
There exists a realisation $(n_{y}, n_{x}, n_{u}, A, B, C, D) \in LSP$ with finite state-space dimension if $\rank(H_{W}) < \infty$ and $W(0) = D$ where $H_{W}$ is the infinite Hankel matrix and $W(0)$ is the impulse response function.
}}}

\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Minimality of a Realisation)}.}\textit{
The realisation $(n_{y}, n_{x}, n_{u}, A, B, C, D) \in LSP$ with finite state-space dimension. The following statements are equivalent:
\begin{itemize}
    \item The realisation is miniaml
    \item $n_{x} = \rank(H_{W}) < \infty$
    \item $(A, B)$ controllable, $(A, C)$ observable
\end{itemize}
Classify:
\small
$$
LSP_{\min} = \left\{\begin{array}{c}
   (n_{y}, n_{x}, n_{u}, A, B, C, D) \in LPS\; |\\
   \rank(\mathcal{C}(A,B)) = n_{x}, \;
   \rank(\mathcal{O}(A,C)) = n_{x}\\
   W(0) = D,\; W(t) = CA^{t-1}B\; \forall t\in T
\end{array}\right\}
$$
\normalsize
}}}

Note that all minimal realisation can be related through a similarity transformation of the form
$$
\tilde A = TAT^{-1}, \tilde B = TB, \tilde C = CT^{-1}, \tilde D = D
$$

Note that if there exists a realisation, we can decompose $H_{W}$ as 
$$
H_{W} = \sup_{k,m \in \mathbb{Z}_{+}}\mathcal{O}_{k}(A, C) \mathcal{C}_{m}(A, B)
$$
Note that we also have 
\begin{align*}
&n_{x} = \rank(H_{W}(k, m)\\
&\iff^{(1)}\quad n_{x} = \rank(\mathcal{O}_{k}(A, C)), n_{x} = \rank(\mathcal{C}_{m}(A,B))\\
&\iff^{(2)}\quad n_{x} = \rank(\mathcal{O}(A, C)), n_{x} = \rank(\mathcal{C}(A,B))\\
&\iff \text{$(A, C)$ observable, $(A, B)$ controllable}
\end{align*}
(1) follows from Sylvesters inequality and (2) follows from Cayley-Hamilton.

Note that we can reduce a realisation to a minimal realisation by sequential Kalman decomposition into an observable and controllable sub-space.

\fbox{\parbox{\columnwidth}{
\textbf{Note \textnormal{(Infinite Hankel Matrix Problem)}.}
The rank of the infinite Hankel matrix in terms of computation theory is undecidable, however we can make adequete numerical approximations on order to draw useful conclusions
}}


## Covariance Functions and Dissipative Systems
\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Dissipative Linear Systems)}.}\textit{
Consider $(n_{y}, n_{x}, n_{u}, F, G, H, J) \in LSP$. Define the supply rate $h: \R^{n_{y}}\times \R^{n_{y}}\to \R$such that 
$$
h(t) = u(t)^{\top}y(y)
$$
Call this system dissipative with supply rate $h$ if there exists a storage function $S(x)$ satisfying the dissipation inequality
$$
S(x(t)) - S(x(t)) - \sum_{r=s}^{t-1} h(u(r), y(r)) \leq 0
$$
}}}
The intuition here is the following $S(x(t)) - S(x(s))$ is the storage. $\sum_{r=s}^{t-1} h(u(r), y(r))$ is the energy supplied. The sum should be negative and hence energy is dissipated. Now 2 questions arise:

a. When is a linear system dissipative?
b. If a system is dissipative, classify all storage functions.

We interpret available storage as the maximal amount of energy which can be extracted from the system over the future interval. We write:
$$
S^{-}(x) = \sup_{(t,x_{1}), u\in(F(T_{d}, U, 0, x, t, x_{1})} \left[ 
-\sum_{r=0}^{t-1} h(u(r), y(r))
\right]
$$

The system is dissipative if and only if 

- The available storage is a finite valued function
- The available storage is a storage function
- $0 \leq S^{0} \leq S$

We can also define the required supply. Consider a linear control system and supply rate $h$. Define the required supply as
$$
S^{+}(x) = \inf \sum_{r=s}^{-1}h(u(r), y(r))
$$
We have that $S^{+} \geq S \geq S^{0} \geq 0$. 

Note that we can relate dissipativity to covariance functions. A system is dissipative if and only if $W$ is a PD function which happens if and only if $W$ is a covariance function. See the notes/book for proof.

Define the set of state variance matrices. Consider a linear system with the assumption
\begin{align*}
lsp = &(n_y, n_{x}, n_{u}, F, G, H, J) \in LSP\\
&J + J^{\top} \succ 0, \text{spec}(F) \subset \mathbb{D}_{o}\\
lspd = &(n_y, n_{x}, n_{u}, F^{\top}, H^{\top}, G^{\top}, J^{\top}) \in LSP\\
&J + J^{\top} \succ 0, \text{spec}(F^{\top}) \subset \mathbb{D}_{o}
\end{align*}
Where $lsp$ is a linear system and $lspd$ is the dual representation. Define the set of state matrices of storage based on $lsp$, define the set state variance matrices based on $lspd$.

\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Algebraic Characterization of Dissipativeness)}.}\textit{
If the system is dissipative then there exists a minimal state-variance matrix which is a solution of the ARE of stochast realisation. Note that the ARE does not have a unique solution unless we impose
\begin{align*}
    &Q \succ 0\\
    &J + J^{\top} - HQH^{\top} \succ 0\\
    &\text{spec}(F-(G-FQH^{\top})(J+J^{\top} - HQH^{\top})^{-1}\\
    &\qquad \times (G-FQH^{\top})^{\top}) \subset\mathbb{D}_{o}
\end{align*}
}}}


## Proof of Theorem Weak Gaussian Stochastic Realisation
Assume there exists a realisation 
\begin{align*}
x(t+1) &= Ax(t) + Mv(t), \quad x(0)=x_{0} \in G(0, Q_{x_{0}})\\
y(t) &= Cx(t) + Nv(t) \quad \text{spec}(A) \subset D_{o}\\
\exists Q_{x} &\in  \R^{n_{x}\times n_{x}}_{pds}:\\
Q_{x} &= AQ_{x}A^{\top} + MM^{\top}
\end{align*}
Then define 
\begin{align*}
Q_{x^{+},y} &= AQ_{x}C^{\top} +MN^{\top}\\
Q_{y} &= CQ_{x}C^{\top} +NN^{\top}\\
\end{align*}
and $F = A$, $H = C$, $G = Q_{x^{+},y}$, $J+J^{\top} = Q_{y}$. Then define the impulse response function in terms of these functions. We can show that 
$$
H_{W}(k, m) = \mathcal{O}_{k}(H, F) \mathcal{C}_{m}(F, G)
$$
which has rank $\leq n_{x}$ implying the infinite Hankel matrix has finite rank.
This can be used to show that $Q_{x} = Q_{W}$ where $W$ is impulse response function and it follows that the realised system is a weak Gaussian Stochastic Realisation.

Note that controllability of $(F, G)$ is equivalent to $(A_{b}, C_{b})$ is an observable pair. Hence we need this to show minimality.


## Canonical Forms
For a considered covariance function there exists a set of minimal weak Gaussian stochastic realisations. This set, in general, may be large. Mostly one selects the Kalman realisation.

Consider a set $X$ with an equivalence relation $E$ defined on it:
$$
E \subseteq X \times X
$$
Where we have 

1. $(x, x) \in E$
2. $(x, y) \in E \implies (y, x) \in R$
3. $(x, y) \in E, (y, z) \in E \implies (x,z)\in E$

We define a canonical form of $(X, E)$ as
$$
X_{cf} \subseteq X: \forall x \in X, \exists x_{cf}\in X_{cf}: (x, x_{cf})\in E
$$
Note that one can interpret this geometrically. 

### Observable Canonical Form
\begin{align*}
x(t+1) &= Ax(t), \quad x(0) = x_{0}\\
y(t) &= Cx(t)
\end{align*}

\begin{gather*}
A_{cf} = \begin{bmatrix}
    0 & 1 & 0 & \cdots & 0 & 0\\
    0 & 0 & 1 & \cdots & 0 & 0\\
    \vdots &  &  & \ddots &  & \vdots\\
    0 & 0 & 0 & \cdots & 1 & 0\\
    0 & 0 & 0 & \cdots & 0 & 1\\
    -a_{0} & -a_{1} & -a_{2} & \cdots & -a_{n_{x}-2} & -a_{n_{x}-1}\\
\end{bmatrix}\\
C_{cf} = \begin{bmatrix}
    1 & 0 & \cdots & 0
\end{bmatrix}
\end{gather*}
Where $a_{i}$ follows from the Cayley-Hamilton theorem.
