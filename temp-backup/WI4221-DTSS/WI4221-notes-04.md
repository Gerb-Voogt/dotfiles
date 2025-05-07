---
documentclass: article
classoption: twocolumn
---
# Lecture 04: Time-Invariant Stochastic Systems

## Controllability
Controllability is a necessary and sufficient condition for the existence of a stabalizing control law. It has been defined for the following:

1. Sets and Maps
2. Deterministic Linear Systems
3. Stochastic Systems
4. Gaussian Systems


\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Controllability of a map)}.}\textit{
Consider a tuple of sets and maps $(U, X, Y, g: U\to X, h: X\to Y)$. Call $g: U\to X$ the input-to-state map. Call the tuple controllable with respect to the subset $X_{co} \subseteq X$ if 
\begin{align*}
g: U &\to X_{co} \subseteq X \text{ is surjective}\\
&\iff \forall x_{c} \in X_{co} \subseteq X, exists u_{c} \in U: x_{c} = g(u_{c})
\end{align*}
If in addition $X_{co} = X$ then $g$ is completely surjective and the tuple is completely controllable.
}}}

Interpetation: For each state there exists an input to reach that state. Note that in the case that 
$$
g(u) = Gu
$$
we have complete surjectivity iff
$$
\rank(G) = \text{dim}(\text{Im}(G)) = n_{x}
$$
For time varying linear systems we say that $x_{a} \in X_{co}\subseteq X$ controllable on $T = \{t_{0}, t_{0}+1, \cdots , t_{0} + t_{1}\}$ if the following input-to-state map is surjective:
$$
\{
u(t_{0}), u(t_{0}+1),
\cdots , u(t_{0} + t_{1}
\} \mapsto x(t_{0} + t_{1}) = x_{a}
$$
If this holds for arbitrary $t_{0}, t_{1}$ and $X_{co} = X$, then we have complete controllability. We can again define this in terms of matrices of the linear time varying system if
$$
\mathcal{C}(A, B: t_{0}:t_{0}+t_{1}-1) = \cdots 
$$
Where we have controllability if 
$$
\mathcal{C}(A, B, t_{0}:t_{0}+t_{1}-1) = n_{x}
$$
In the LTI case this reduces to the well known controllability condition.

\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Controllability of LTI Systems)}.}\textit{
LTI system $(A, B)$ is controllable if and only if
$$
\rank(\mathcal{C}(A, B)) = n_{x}
$$
Where 
$$
\mathcal{C}(A, B) = \begin{bmatrix}
    B & AB & \cdots & A^{n_{x}-1}B
\end{bmatrix}
$$
}}}

**General advice**: Look at the singular values of the controllability matrix. If the singular values are further apart than a factor 10, this may indicate poor controllability and further investigation may be needed.

An interesting note is that by Kalman's work, we can decompose a system which is not controllable into a controllable normal form, where we split the system in a part that is and isn't controllable. We have 
$$
x(t+1) = Ax(t) + Bu(t),\qquad x(0) = x_{0}
$$
Which under $z(t) = Sx(t)$ yields
$$
z(t+1) = \begin{bmatrix}
    A_{11} & A_{12}\\
    0 & A_{22}
\end{bmatrix}z(t) + \begin{bmatrix}
    B_{1}\\ 0
\end{bmatrix}u(t), \qquad z(0) =z_{0}
$$
Where $(A_{11}, B_{1})$ is controllable.

### Stabilizability
$(A, B)$ is a stabilizable type if one one of the following holds:

a. $\text{spec}(A_{22}) \subset \mathbb{D}_{O}$ after transfomation into Kalman form
b. $\forall \lambda \in \Lambda(A)$ we have $\lambda \in \mathbb{D}_{O}$ or Hautus' test (HJB lemma) holds ($n_{x} = \rank([A-\lambda \mathcal{I} \; B])$
c. $\lambda \in \Lambda(A)$ are spectrally assignable

Note: $\mathbb{D}_{O}$ is the complex open unit disc:
$$
\mathbb{D}_{O} = \{c \in \mathbb{C}\;|\; |c| < 1\}
$$
Note that for LTI systems to be stable we must have
$$
\Lambda(A) \subset \mathbb{D}_{O}
$$


## Time-Invariant Gaussian Systems
### Supportable Pairs
Closely related but distinct from controllable pairs
\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Supportable Pair)}.}\textit{
Consider
$$
x(t+1) = Ax(t) + Mv(t)
$$
Call the matrix tuple $(A, M)$ a supportable pair if 
$$
n_{x} = \rank(\mathcal{C}(A, M))
$$
}}}

### Lyapunov Equation
\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Lyapunov Matrix Equation)}.}\textit{
Consider a time-invariant Gaussian sstems. Define the recursion of the state variance function and the discrete-time Lyapunov equations by the respective formulas:
\begin{align*}
  Q_{x}(t+1) &= AQ_{x}(t)A^{T} + MM^{T},\qquad Q_{x}(0) = Q_{x_{0}}\\
  Q &= AQA^{T} + MM^{T}
\end{align*}
With $m_{x}(t) = \mathbb{E}\left[x(t)\right]$ and $Q_{x}(t) = \mathbb{V}(x(t))$
}}}
A very important theorem on the Lyapunov equation is the following: For time invariant Gaussian systems if the matrix $A$ is exponentially (asymptotically) stable, then 
\begin{align*}
Q &= \lim_{t\to \infty} Q_{x}(t)\\
Q &= AQA^{T} + MM^{T}
\end{align*}
Thus the covariance convergence to a unique solution of the Lyapunov equation iff $A$ is stable. Note that we also have that $Q \succ 0$.

We also have that any 2 of the following 3 statements imply the 3rd:

1. $\Lambda(A) \subseteq \mathbb{D}_{O}$
2. $(A, M)$ is supportable Pair
3. $Q \succ 0$

Exponential stability implies asymptotic convergence. 
$$
\exists c \in \R_{+}, \exists r \in (0, 1): \|Q_{x}(t) - Q_{x}(\infty)\|_2 \leq c|r|^t
$$
where we define
\begin{align*}
Q_{x}(\infty) &= \lim_{t\to \infty} \frac{1}{t} \sum_{s=0}^{t-1}Q_{x}(s)\\
Q_{x}(\infty) &= AQ_{x}(\infty)A^{T} + MM^{T}
\end{align*}

Note that this is also related to the observability Grammian such that if we have 
\begin{align*}
    Q_{c} &= AQ_{c}A^{T} + MM^{T}\\
    Q_{o} &= A^{T}Q_{o}A + C^{T}C
    \text{tr}(CQ_{c}C^{T}) = \text{tr}(M^{T}Q_{o}M)
\end{align*}

Slide 27/56 lecture 04 highlights some useful inequalities when proving lower bounds and upper bounds for e.g. Ricatti equations.


## Invariant Probability Measures
We can define probability measures on an image space. Consdier a stochastic system with state and output $(x, y)$. For time $t\in T$, consider
$$
\begin{bmatrix}
    x(\omega, t+1)\\
    y(\omega, t)
\end{bmatrix}:\Omega \to \R^{n_{x}+n_{y}}
$$
This map induces a probability measure on the image space according to 
$$
(X\times Y, B(X\times Y)) = (\R^{n_{x}+n_{y}}, B(\R^{n_{x}+n_{y}}))
$$
For $A \in B(\R^{n_{x}+n_{y}})$ we have 
$$
P_{(x^{+}, y),t}(A) = P(\{\omega \in \Omega|(x(\omega, t+1), y(\omega,t )) \in A\}
$$
Then $P$ is a probability measure on $X\times Y$ if this concers a Gaussian system then that measure is a Gaussian measure. We call the measure invariant if 
$$
\exists P_{(x^{+},y)}: B(X) \otimes B(Y) \to [0, 1]
$$
such that 
$$
P_{(x^{+}, y), t} = P_{(x^{+}, y)} \quad \forall t \in T
$$
and we define $P_{x} = P_{(x^{+}, y)|B(X)}$ and $P_{y} = P_{(x^{+}, y)|B(Y)}$

Consider now a time-invariant Gaussian system $(A, B, M, N)$ with $x_{0} \in G(0, Q_{x_{0}})$ and $\Lambda(A) \in \mathbb{D}_{O}$. There exists an invariant measure of the system which is a Gaussian measure and which may be constructed as defined below:
$$
\begin{align*}
    Q_{x} &= AQ_{x}A^{T} + MM^{T},\\
    Q_{y} &= AQ_{x}A^{T} + NN^{T},\\
    Q_{x^{+}y} &= AQ_{x}C^{T} + MN^{T}\\
    Q_{(x^{+}, y)} &= \begin{bmatrix}
        Q_{x} & Q_{x^{+}y}\\
        Q_{x^{+}y}^{T} & Q_{y}\\
    \end{bmatrix}
\end{align*}
$$
Where $G(0, Q_{(x^{+}, y)})$ is the invariant probability measure.

Note that if the initial state $x_{0}$ does not have the invariant state probability measure, the in the limit the distribution converges to the invariant Gaussian measure:
$$
\begin{bmatrix}
    x(t+1)\\ y(t)
\end{bmatrix} \in G
$$
And we have 
\begin{gather*}
D - \lim_{t\to \infty}G\left(
\begin{bmatrix}
   m_{x}(t+1)\\ m_{y}(t)
\end{bmatrix}, \begin{bmatrix}
    Q_{x^{+}}(t+1) & Q_{x^{+}y}(t)\\
    Q_{x^{+}y}(t)^{T} & Q_{y}(t)
\end{bmatrix}
\right)\\ = G(0, Q_{(x^{+}, y)}
\end{gather*}
Note that the support of the invariant state pdf $x(t)$ equals the state space $\R^{n_{x}}$ is equivalent to the condition that $Q_{x} \succ 0$ as well as the condition that $(A, M)$ is a supportable pair. To prove this we look at the characteristic equation $\mathbb{E}\left[\exp(jw (x, y)^{T} | F_{t}^{x})\right]$.

\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Backward Supportable Pair)}.}\textit{
Consider a backward time-invariant Gaussian System
$$
x(t-1) = A_{b}x(t) + M_{b}v_{b}(t), \qquad x(0) = x_{0}
$$
Call the tuple $(A_{b}, M_{b})$ a backward supportable pair if 
$$
\rank(\mathcal{C}(A_{b}, M_{b}) = n_{x}
$$
Call the system representation a backward supportable system representation if $(A_{b}, M_{b})$ is a backward-supportbale pair.
}}}

We can use the matrix $Q_{x}$ to derive a relation between the forward and backward representation, as $Q_{x}$ is invariant under the system representation. We have $Q_{x}$ solve 
$$
Q_{x} = A_{f}Q_{x}A_{f}^{T} + M_{f}M_{f}^{T}
$$
Then we have that the system representations are similarity transformations of one another
\begin{align*}
A_{f} &= Q_{x}A^{T}_{b}Q_{x}^{-1}\\
C_{f} &= C_{b}Q_{x}A^{T}_{b}Q_{x}^{-1} + N_{b}Q_{v_{b}}M_{b}^{T}Q_{x}^{-1}\\
A_{b} &= Q_{x}A^{T}_{f}Q_{x}^{-1}\\
C_{b} &= C_{f}Q_{x}A^{T}_{f}Q_{x}^{-1} + N_{f}Q_{v_{f}}M_{f}^{T}Q_{x}^{-1}
\end{align*}
Note that $\Lambda(A_{f}) = \Lambda(A_{b})$.

## Stochastic Observability and Co-Observability
Consider a time-invariant stochastic system and assume that there exists an invariant probability measure of the system, and that the state and output have the invariant measure. Call the state $x(t_{0})\in C$ stochastically observable if the distribution of the future outputs is injective on the support of $x$. For the co-observability case, we have the same condition but on the past outputs.

Note that this all reduces in the time-invariant case to the check that 
$$
\rank(\mathcal{O}(A, C)) = n_{x}
$$

\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Characterization of Stochastic Observability)}.}\textit{
Consider a forward time-invariant Gaussian System
\begin{align*}
    x(t+1) &= Ax(t) + Mv(t), \quad x(0) = x_{0}\\
    y(t) &= Cx(t) + Nv(t) \quad v \in G(0, I)\\
    &\Lambda(A) \in \mathbb{D}_{O}\\
    &\text{Then } \exists  Q_{x}:\\
    Q_{x} &= AQ_{x}A^{T} + MM^{T};\\
    &x_{0}\in G(0, Q_{x}) \implies x(t) \in G(0, Q_{x}) \forall t
\end{align*}
This system is stochastically observable if one of the following holds:
\begin{enumerate}
    \item $\text{ker}(Q_{x}) = \text{ker}(\mathcal{O}(A, C)Q_{x}$
    \item $(A, M)$ is a supportable pair and $(A, C)$ is an observable pair
\end{enumerate}
}}}

Note that like for controllability we can do a Kalman decomposition to write the system in Kalman Observable form 
\begin{align*}
    x(t+1) &= \begin{bmatrix}
        A_{11} & 0\\
        A_{21} & A_{22}\\
    \end{bmatrix}x(t) + \begin{bmatrix}
        M_{1}\\ M_{2}
    \end{bmatrix}v(t)\\
    y(t) &= \begin{bmatrix}
        C_{1} & 0
    \end{bmatrix} + Nv(t)\\
    &\Lambda(A) \subset \mathbb{D}_{o}, (A_{11}, C_{1}) \text{ an observable pair}
\end{align*}
Note that $x_{2}$ is excited by the noise but not present in $y$ directly or via $x_{1}$, so we cannot "see" $x_{2}$ at the output side of the system.

\fbox{\parbox{\columnwidth}{
\textbf{Note.}
We can write out the same proof and theorems but for the backwards representation of the system. Using $Q_{x}$ as a coordinate transformation we can show these to be equivalent.
}}

We can use these outlined properties to show that some parts of the state space model are considered non-relevant if they are not supportable and not visible in the output. Then we can prove that a state-space realisation is in some sense minimal if we have a time-invariant Gaussian system with 

- $(A, M)$ supportable
- $(A, C)$ observable
- $(A_{b}, C_{b})$ observable


## Time-Invariant Stochastic Systems
We can represent the system in terms of indicator functions.  We can extend many results from Gaussian systems to these systems, however care needs to be taken
[insert system representation]

We have probability measure $p_{x}(t) = \mathbb{E}\left[i_{x}(t)\right]$ and $p_{y}(t) = \mathbb{E}\left[i_{y}(t)\right]$.

The (sub)systems might be irreducible and nonperiodic. There are some questions of existence and uniqueness of steady state equation $p_{x_{s}} = Ap_{x_{s}}$. Stochastic observability and stochastic co-observability are characterized in terms of the system matrices.
