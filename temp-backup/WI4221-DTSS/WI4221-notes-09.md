---
documentclass: article
classoption: twocolumn
---

# Lecture 09: Optimal Stochastic Control with Complete Observations on an Infinite Horizon

## Infinite-Horizon Cost Criteria
For infinite horizon we will use $T = \mathbb{N} = \{i\}_{i=1}^{\infty}$. We use infinite control laws because typically in engineering systems run for long periods of time. The effects near the end point of the time horizon are not of interest. The optimal control law is simple to implement because it is not explicitly time dependent (time-invariant).

\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Cost Function)}.}\textit{
Conside rthe time-invariant recursive stochastic system
$$
x(t+1) = f(x(t), u(t), v(t)),\; x(0) = x_{0}
$$
With $b: X \times U \to \R_{+}$ and the set $G_{\text{ti},m} = \{g: X \to U\;|\; g \text{ measurable}\}$ resulting in input $u^{g}(s) = g(x^{g}(s))$. We also define respectively:
\begin{itemize}
    \item Average Cost: 
    $$
    J_{\text{ac}}(g) = \limsup_{t\to \infty} \frac{1}{t} \mathbb{E}\left[\sum_{s=0}^{t-1}b(x^{g}(s), u^{g}(s))\right]
    $$
    \item Discounted Cost: 
    $$
    J_{\text{dc}}(g) = \mathbb{E}\left[\sum_{s=0}^{\infty}r^{s}b(x^{g}(s), u^{g}(s))\right]
    $$
    \item Total cost Cost: 
    $$
    J_{\text{dc}}(g) = \mathbb{E}\left[\sum_{s=0}^{\infty}b(x^{g}(s), u^{g}(s))\right]
    $$
\end{itemize}
}}}

In engineering we will use average cost (near and distant future have equal weight). Discounted cost is often used in RL and economics. Total cost might not be super useful? Not much used.

We distinguish the following 4 cases for control synthesis:

- Finite state problems
- Countably infinite states
- Uncountable state-space with positive cost
- Uncountable state-space with negative cost


All cases require different analytical methods.

\fbox{\parbox{\columnwidth}{
\textbf{Problem \textnormal{(Optimal Stochastic Control with complete observations and average cost)}.}\textit{
Let $x(t+1) = f(x, u, v)$, $x(0) = x_{0}$ with $v: \Omega \times T \to \R^{n_{v}}$ be independent and stationary. Then define $G_{tv}$ as  the set of Borel measurable time-varying control laws. Using average cost, the goal is to find $\inf_{g\in G_{ac,f}}\; J_{ac}(g)$.
}}}

Assumptions on controllability is needed else $G_{ac,f} = \emptyset$.

## Average Cost - Gaussian Stochastic Control Systems

\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Average-cost dynamic programming equation (DPE-AC))}.}\textit{
$(J_{ac}^{*}, V)$ with $J_{ac}^{*}\in \R_{+}$ and $V: X\to \R_{+}$. Assume that $\forall x_{V}\in X,\; \exists U(x_{V}) \subseteq U$. Define the DPE-AC for the pair $(J_{ac}^{*}, V)$ as 
$$
\begin{align*}
J_{ac}^{*} + V(x_{V}) = \inf_{u_{V}\in U(x_{V})} \quad \{b(x_{V}, u_{V})\\ + \mathbb{E}\left[V(f(x_{V}, u_{V}, v(t)))\;|\;F^{x_{V}, u_{V}} \right]\}
\end{align*}
$$
Where $f_{v(t)}$ is the distribution of the noise process. Recall the notation
\begin{gather*}
\mathbb{E}\left[ V(f(x_{V}, u_{V}, v(t)))\;|\;F^{x_{V}, u_{V}} \right]\\ = \int V(f(x_{V}, u_{V}, w))f_{v(t)} \,(dw)
\end{gather*}
This is also often called the Bellman-Hamilton-Jacobi (HJB) equation. In continuous time, this is a Partial Differential Equation.
}}}

Lets call $J_{ac}^{*}$ the value and $V$ the value function of the DPE-AC. The DPE-AC is for finding the pair $(J_{ac}^{*}, V)$. We now need to find a procedure to compute this pair. The DPE-AC is the infinimization is the sum of cost rate $b$ and the current estimate of optimal cost-to-go.


\fbox{\parbox{\columnwidth}{
\textbf{Proposition \textnormal{(Uniqueness of the DPE-AC Solution)}.}\textit{
If $(J_{ac,1}^{*}, V)$ and $(J_{ac,2}^{*}, V)$ are two solutions of DPE-AC, then $J_{ac,1} = J_{ac,2}$. If $(J_{ac}^{*}, V)$ is a solution of DPE-AC and $c\in \R_{+}$ then $(J_{ac}^{*}, V+c)$ is another solution.
}}}


\begin{algorithm}
    \caption{Finding a control law using DPE-AC}
    \begin{algorithmic}
       \State{Find $(J_{ac}^{*}, V)$ of DPE-AC} 
        \State{Where we have $J_{ac}^{*} + V(x_{V}) = \inf_{u_{V}}\{b(x_{V}, u_{V}) + \mathbb{E}\left[V(f(x_{V}, u_{V}, v(t)))\;|\;F^{x_{V}, u_{V}} \right]\}$}
        \If{for all $x_{V}\in X, \exists u^{*}\in U(x_{V})$ such that infinimum attained}
            \State{define $g^{*}(x_{V}) = u^{*}, g^{*}: X \to U$}
            \If{$g^{*}$ measurable}
                \Return{$(J_{ac}^{*}, V, g^{*})$}
            \EndIf
        \EndIf
    \end{algorithmic}
\end{algorithm}


Note that to check whether a candidate solution is actually a solution of the DPE-AC?

1. Formulate a candidate solution $(J_{ac}^{*}, V)$
2. Calculate the RHS of the DPE-AC using the candidate solution
3. Check whether the RHS equal the LHS of the DPE-AC which is $J_{ac}^{*} + V(x_{V})$. If so then the candidate solution is a solution.

Typically, run a few steps of the finite horizon DP procedure and formulate a conjecture about the analytic form for the infinite horizon and check whether the candidate solution is a solution.

There are a few cases with explicit optimal control law

- Gaussian Stochastic control system system with quadratic cost rate
- Finite stochastic control systems
- LEQG
- Specific cases with countable state set

For control theory with discounted cost (e.g. RL) we can do simpler proofs using fixed-point equation and Banach fixed-point theorem.


\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(LinLQG optimal stoc. control with complete observations, infinite horizon and average cost)}.}\textit{
\begin{align*}
x(t+1) &= Ax(t) + Bu(t) + Mv(t), \quad x(0) = x_0, \\
z(t) &= C_z x(t) + D_z u(t), \quad n_z \leq n_z, D_z \in \mathbb{R}^{n_z \times n_u}, \\
&\text{rank}(D_z) = n_u \Rightarrow D_z^T D_z > 0, \\
&\text{past-state info structure, } \mathcal{G}_{tv} \text{ control laws;} \\
x^g(t+1) &= A x^g(t) + B g_t(x(0{:}t)) + M v(t), x^g(0) = x_0, \\
z^g(t) &= C_z x^g(t) + D_z g_t(x(0{:}t)), \\
u^g(t) &= g_t(x^g(0{:}t)); \quad J_{ac} : \mathcal{G}_{tv} \to \mathbb{R}_+ \cup \{+\infty\}, \\
J_{ac}(g) &= \limsup_{t_1 \to \infty} \frac{1}{t_1} \mathbb{E} \left[ \sum_{s=0}^{t_1 - 1} z^g(s)^T z^g(s) \right], \\
Q_{cr} &= \begin{bmatrix}
C_z^T C_z & C_z^T D_z \\
(C_z^T D_z)^T & D_z^T D_z
\end{bmatrix}.
\end{align*}
}}}

We assume LQG average cost is given as 
$$
\begin{align*}
A_{c} &= A - B(D_{z}^{T}D_{z})^{-1}D_{z}^{T}C_{z}\\
C_{c}^{T}C_{c} &= C_{z}^{T}C_{z} - C_{z}^{T}D_{z}(D_{z}^{T}D_{z})^{-1}D_{z}^{T}C_{z}
\end{align*}
$$
Assumption (a) holds if  holds if 
$$
(A, B) \text{ controllable}, \quad 
(A_{c}, C_{c}) \text{ observable}
$$
Assumption (b) holds if  holds if 
$$
(A, B) \text{ stabilizable}, \quad 
(A_{c}, C_{c}) \text{ detectable}
$$
Note that (a) implies (b) but (b) does not imply (a). If assumption (b) holds, then there exists a matrix $F$ such that $A + BF$ is Schur stable. In other words, the variance of the closed loop system follows the Lyapunov equation (both in the invariant as well as the time-varying case). In the limiting case, the time-varying case converges to the Lyapunov equatio in the time invariant case. Interestingly, the equation 
$$
Q_{x}^{g} = \lim_{t\to \infty} \frac{1}{t} \sum_{s=0}^{t-1} Q_{x}^{g}(s)
$$
also holds.


\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Contorl ALgebraic Riccati Equation)}.}\textit{
Define the CARE (Control Alagebraic Riccati Equation) with side conditions
$$
\begin{gather*}
Q_{c}^{*} = A^{T}Q_{c}^{*}A + C_{z}^{T}C_{z} - [A^{T}Q_{c}B + C_{z}^{T}D_{z}]\\
\times [B^{T}Q_{c}^{*}B +D_{z}^{T}D_{z}]^{-1}[A^{T}Q_{c}^{*}B + C_{z}^{T}D_{z}]
\end{gather*}
$$
With the side conditions that $Q_{c}^{*} \succeq 0$ and $\text{spec}(A+BF(Q_{c}^{*}) \subset \mathbb{D}_{o}$
}}}.


The optimal control law is $g^{*}$ and is linear function of the state. It is optimal over the set of nonlinear Borel-measurable control laws. In the literature we often define 
$$
J_{ac}(g^{*}) - J_{ac}(g_{s}) \leq 0
$$
as the regret of using non-optimal control law. We can explicitly show that For non-optimal control laws satisfying stability we have that 
$$
g_{s}(x^{g}) = \text{tr}(M^{T}(Q_{c}^{*} - Q_{c}^{g_{s}})M) \leq 0
$$
Where $Q_{c}^{g_{s}}$ satisfies a control Lyapunov equation. 

\begin{algorithm}
    \caption{}
    \begin{algorithmic}
        \State{Check whether conditions (a) or (b) are satisfied}
        \State{Compute $Q_{c}^{*}$ using the Control ARE}
        \State{Compute $g^{*}(x) = F(Q_{c}^{*})x$, $J_{ac}^{*} = \text{tr}(M^{T}Q_{c}^{*}M$}
        \State{}\Return{$(F(Q_{c}^{*}, J_{ac}^{*}, Q_{c}^{*})$}
    \end{algorithmic}
\end{algorithm}


\fbox{\parbox{\columnwidth}{
\textbf{Problem \textnormal{(Has the value decreased?)}.}\textit{
In general, it is not true that the value decreases when compared to doing nothing. That is, in general, there does not exist an $\varepsilon$ such that 
$$
0 \leq \frac{J_{ac}(g^{*}_{\varepsilon})}{J_{ac}(g^{*}_{z})}M \varepsilon
$$
}}}


## Average Cost - Finite Stochastic Control System
\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Average-Cost finite state-space)}.}\textit{
\begin{align*}
T &= \mathbb{N}, X, U \text{ finite sets}\\
x(t+1) &= f(x, y, v), x(0) = x_{0}\\
\end{align*}
With past state filtration $F_{t}^{x}$ and $G_{tv}$. The closed loop system is 
\begin{gather*}
x^{g}(t+1) = f(x^{g}, g(t, x^{g}(0:t), v), x^{g}(0) = x_{0},\\
u^{g}(t) = g(t, x^{g}(0:1))
\end{gather*}
Cost rate $b: X \times U \to \R_{+}$, $b_{\max}$ exists and the average cost is finite. Every control law has finite average cost.
}}}

[insert procedure (slide 49/65)]



\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Sufficient condition for optimality)}.}\textit{
Consider the optimal stochastic control problem for a finite-stochastic control system with average cost and with complete observations on an infinite horizon. 
\begin{enumerate}
    \item If there exists a solution $(J_{ac}^{*}, V)$ of the DPE-AC and,
    \item if the control law $g^{*}\in G$ is produced by the above procedure, then
\end{enumerate}
$g^{*}$ is an optimal control law and $J^{*}_{ac}$ is the value of the problem.
}}}

\fbox{\parbox{\columnwidth}{
\textbf{Defintion \textnormal{(Reducible Stochastic Matrices)}.}\textit{
A stochastic matrix $P$ is reducible if $\exists Q\in \R^{n\times n}$ such that
$$
QPQ^{-1} = \begin{bmatrix}
    P_{11} & P_{12}\\
    0 & P_{22}
\end{bmatrix}
$$
}}}

\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Solution DPE Finite State)}.}\textit{
Consider the average cost optimal control problem (finite case). Assume $P(g)$ is irreducible. For all time-invariant control laws
\begin{enumerate}
    \item[(a)] The value function optimum exists
    \item[(b)] the value function optimum is unique up to additive constant
    \item[(c)] 
    \item[(d)]
\end{enumerate}
}}}


Finding control laws:

1. Value iteration, may not converge in finite steps
2. Policy (control-law) Iteration, guaranteed to converge in finite steps


\begin{algorithm}
    \caption{Policy iteration}
    \begin{algorithmic}
        \Require{$b: X\times U \to \R_{+}$, $A: U\to \R^{n_{x}\times n_{x}}_{st}$, $g_{0}: X\to U$ time-invariant Markov}
    \State{Init with $m = 0$, solve}
        $$
        J(g_{0}) \boldsymbol{1}_{n_{x}} + V(g_{0}) = b(g_{0}) + A(g_{0})V(g_{0})
        $$
    \State{for $V(g_{0})$ and $J(g_{0})$, where}
    $$
    b(g_{0}) = \begin{bmatrix}
        b(x_{1}, g_{0}(x_{1}))\\
        \vdots\\
        b(x_{n}, g_{0}(x_{n}))
    \end{bmatrix}
    $$
    \State{Subtract the last equation form the preceeding $(n-1)$ equations to obtain a set of $(n-1)$ equations without $J(g_{0})$.}
    \State{... CONTINUE HERE}
    \end{algorithmic}
\end{algorithm}
