---
documentclass: article
classoption: twocolumn
---
# Lecture 03: Stochastic Systems

## Concept of Stochastic Systems
\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Stochastic System)}.}\textit{A stochastic system is a collection satisfying
\begin{align*}
  &(F^{y+}_{t} \vee F^{x+}_{t}, F_{t-1}^{y-}\vee F^{x-}_{t}\;|\; F^{x(t)}) \in CI\; \forall t \in T\\
  &\text{where,}\\
  &(\Omega \mathcal{F}, P) \text{ complete probability space}\\
  &T \subseteq \mathbb{Z}, \text{ time index set}\\
  &(Y, B_{Y}), (X, B_{X}), \text{ output and state space}\\
  &y: \Omega \times T \to Y, x: \Omega \times T \to X
\end{align*}
And were we define the sigma algebras
\begin{align*}
    &F_{t}^{x-} = \sigma(\{x(s), \forall s \leq t\}\\
    &F_{t}^{x+} = \sigma(\{x(s), \forall s \geq t\}\\
    &F_{t}^{y+} = \sigma(\{y(s), \forall s \geq t\}\\
    &F_{t-1}^{y-} = \sigma(\{x(s), \forall s \leq t-1\}\\
    &F_{-1}^{y-} = \{\Omega, \emptyset\}
\end{align*}
We denote the entire collection 
$$
\{\Omega, \mathcal{F}, P, T, Y, B_{Y}, X, B_{X}, y, x\}
$$
The future and past are conditionally independent given the current state
}}}

See alternative conditions slide 13/60 lecture 03. All of these equivalently define independence of future and past given the state (Markov property).

### Gaussian System Representation
Time-varying Gaussian system representation in discrete time, forward representation if the output and the state process are define by
\begin{align*}
    x(t+1) &= A(t)x(t) + M(t)v(t)\quad x(0)=x_{0}\\
    y(t) &= C(t)x(t) + N(t)v(t)
\end{align*}
In the case that $A(t), C(t), M(t), N(t)$ are time independent we define the time-invariant Gaussian system representation of the form
\begin{align*}
    x(t+1) &= Ax(t) + Mv(t)\quad x(0)=x_{0}\\
    y(t) &= Cx(t) + Nv(t)
\end{align*}
Where $v(t)\in G(0, I_{n_{v}})$, $x_{0}\in G(m_{x_{0}}, Q_{x_{0}})$. Notation $(n_{y}, n_{x}, n_{v}m A, C, M, N)$. 

In the literature, commonly, the generalised disturbance is used ($v(t) = [r(t), w(t)]^{T}$). Note that another common description that is _not_ equivalent  (and hence results may _not_ be generalised) is given as
\begin{align*}
    x(t+1) &= A(t)x(t) + M(t)v(t)\quad x(0)=x_{0}\\
    y(t+1) &= C(t)x(t) + N(t)v(t)
\end{align*}

The Gausian system is state-output conditionally indpendent if 
$$
(F^{x(t+1)} , F^{y(t)}|F^{x}_{t} \vee F^{y}_{t-1})\in CI \quad \forall t\in T
$$
In the Gaussian representation we write 
$$
\mathbb{E}\left[M(t)v(t)(N(t)v(t))^{T}\right] = 0 \quad \forall t \in T
$$
as a sufficient condition for independence. Gaussian system can also be written in terms of a state transition function
$$
\Phi(t+1,s) = \begin{cases}
A(t)\Phi(t, s) \quad &s < t+1,\\
I_{n_{x}} \quad &s = t+1,\\
0 \quad &s > t+1,
\end{cases}
$$
One can prove that 
\begin{align*}
    x(t) &= \Phi(t,s) x(s) + \sum_{r=s}^{t-1} \Phi(t-1, t)M(r)v(r)\\
    y(t) &= C(t)\Phi(t,s) x(s) + \sum_{r=s}^{t-1} C(t)\Phi(t-1, t)M(r)v(r)\\ &+ N(t)v(t)
\end{align*}
This follows relative directly from a proof by induction. We can show using this representation that $x(t), y(t)$ are jointly Gaussian processes.

Slide 26/60 shows that a Gaussian system representation defines a stochastic system. One can observe slide 30/60 for the derivation of the output process representation.


## Forward and Backward Representation
Systems can also be written in a backwards representation. They start at time $t$ and recurse backward in time rather than forward. We define 
\begin{align*}
x(t-1) &= A_{b}(t)x(t) + M_{b}(t)v_{b}(t)\\
y(t-1) &= C_{b}(t)x(t) + N_{b}(t)v_{b}(t)\\
&T = \{0, -1, -2, \cdots \}
\end{align*}
We can reconstruct the forward representation from this backward representation. The forward and backward representation are related through the covariance of the processes $X$, $Y$ and $V$.

## Observability of Deterministic Linear Systems
\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Injective Functions)}.}\textit{
Let $h: \R^{n_{x}}\to\R^{n_{y}}$, $n_{x},n_{y} \in \mathbb{Z}_{+}$. If 
$$
\forall x_{a},x_{b}\in \R^{n_{x}}, h(x_{a}) = h(x_{b}) \implies x_{a} = x_{b}
$$
This implies that $x_{a}$ can be directly determined from the output $h(x_{a})$.
}}}
In the linear case we write
$$
h(x) = Cx
$$
Where $\text{ker}(C) = \{x_{a} \in \R^{n_{x}}|Cx_{a} = 0\}$ and $\text{Im}(C) = \{Cx_{b} \in\R^{n_{y}}\ | \forall x_{b}\in \R^{n_{x}}\}$. 

\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Observability of a Linear System)}.}\textit{
Consider the time varying linear system
\begin{align*}
  x(t+1) &= A(t)x(t), x(0)=x_{0}\\  
  y(t) &= C(t)x(t),\\ 
  &T = \mathbb{N}, x_{0}\in\R^{n_{x}}
\end{align*}
Define for all $t_{0}\in T$, $t_{1}\in \mathbb{Z}_{+}$ such that $t_{0}+t_{1}-1 \in T$. The state $x(t_{0}) \in\R^{n_{x}}$ to be observable from the future outputs on the interval
$$
\{t_{0}, t_{0}+1,\cdots , t_{0}+t_{1}-1\} \subseteq T
$$
if the following state-to-output map is injective
$$
x(t_{0}) \mapsto \{y(t_{0}), y(t_{0}+1), \cdots , y(t_{0}+t_{1}-1)\}
$$
We call this system observable if the condition above holds for all $t_{0}\in T$ and $x(t_{0}) \in \R^{n_{x}}$.
}}}
If we now define 
$$
\bar y = \begin{bmatrix}
    y(t_{0})\\
    y(t_{0}+1)\\
    \vdots\\
    y(t_{0}+t_{1}-1)
\end{bmatrix}
$$
Which is equivalent to writing $n_{x} = \rank(\mathcal{O})$, where $\mathcal{O}$ is defined as
$$
\mathcal{O}((A, C, t_{0}, t_{1}) = 
\begin{bmatrix}
    C(t_{0})\\
    C(t_{0}+1) \Phi(t_{0}+1, t_{0})\\
    \vdots\\
    C(t_{0}+t_{1}-1) \Phi(t_{0}+t_{1}-1, t_{0})\\
\end{bmatrix}
$$
In the case that $A(t), C(t)$ are time invariant we write
$$
\mathcal{O}(A, C) = \begin{bmatrix}
    C\\ CA\\ \vdots\\ CA^{n_{x}-1}
\end{bmatrix}
$$


## Stochastic Observability and Stochastic Co-Observability
In the stochastic case, observability is not as straightforward to define as the state-to-output map is stochastic. The system is stochastically observable on the interval $(t_{0}, t_{0}+1, \cdots , t_{0}+t_{1}-1)\subseteq T$ if the stochastic state-to-output map is injective on the support of $x(t_{0})$,
$$
x(t_{0}) \mapsto \text{cpdf}(\{
y(t_{0}), y(t_{0}+1), \cdots , y(t_{0}+t_{1}-1)\ | F^{x(t_{0})} \})
$$
This means that by measurements one can _in principle_ approximate the conditional measure used above. Support of the Gaussian random variable $x(t_{0})$ is 
$$
\text{Range}(Q_{x}(t_{0})) = \{Q_{x}(t_{0})x_{a}\in\R^{n_{x}}| \forall x_{a} \in \R^{n_{x}}\}
$$

The system is considered stochastic co-observable if the stochastic state-to-past-output map is injective on the support of $x(t_{0})$:
$$
x(t_{0}) \mapsto \text{cpdf}(\{
y(t_{0}), y(t_{0}-1), \cdots , y(t_{0}-t_{1})\ | F^{x(t_{0})} \})
$$

Note that stochastic observability and stochastic co-observability are **distinct** concepts.


### Rank condition for stochastic observability
Given stochastic forward system $(A(t), C(t), M(t), N(t))$ we can show that this system is stochastically observable if
$$
\mathcal{O}(t_{0}:t_{0}+t_{1}-1) = \begin{bmatrix}
    C(t_{0})\\
    C(t_{0} + 1)\Phi(t_{0}+1, t)\\
    \vdots\\
    C(t_{0}+t_{1}-1)\Phi(t_{0}+t_{1}-1, t)
\end{bmatrix}
$$
See the slides for the backwards representation. This reduces to also a rank condition of the backward representation.
