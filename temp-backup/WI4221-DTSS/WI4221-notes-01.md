---
documentclass: article
classoption: twocolumn
---
# Lecture 01: Introduction and Probability
## Probability Distributions and Measures
### Probability Distribution Function
The definition of pdfs over $\R$ is defined below. We can define them over $\R^{n}$, however this is particularly difficult compared to $\R$ (see Ash, 1972). THe class of pds is a convex set:
$$
\forall f_{1}, f_{2}\text{ pdf and } \forall c \in [0, 1] \implies cf_{1} + (1-c)f_{2} \text{ is a pdf}
$$
\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Probability Distribution Function on $\R$)}.}\textit{A pdf is a function $f: \R\to \R_{+}$ such that 
\begin{enumerate}
    \item $f$ is increasing. $u \leq v\implies f(u) \leq f(v)$
    \item $f$ satisfies the limits $\lim_{u\to -\infty} f(u) = 0$ and $\lim_{u\to +\infty} f(u) = 1$
    \item $f$ is right continuous, satisfying the limit $\lim_{v\downarrow u} f(v) = f(u)$
\end{enumerate}
}}}

There are many subclasses of pdfs. They can be discrete:
$$
f(u) = \sum_{k\in \mathbb{Z}} p(k)I_{[u_{k}, \infty)}(u)
$$
With
$$
I_{[u_{k}, \infty)}(u) = \begin{cases}
0, \quad u \in (-\infty, u_{k})\\
1, \quad u \in [u_{k}, \infty)\\
\end{cases}
$$
Where $p: \mathbb{Z} \to \R_{+}$ is a frequency function satisfying $\sum_{k\in \mathbb{Z}} p(k) = 1$. 

We can also have an absolute continuous pdf:
$$
f(u) = \int_{-\infty}^{u} p(v)\, dv
$$
Note that the integral here is a Lebesgue-Stieltjes integral. We have $p: \R \to \R_{+}$, satisfying $\int_{-\infty}^{\infty} p(v)\, dv = 1$.

### $\sigma$-Algebras
$\sigma$-Algebras formalize probability distributions


\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{($\sigma$-Algebras of subsets of $\Omega$)}.}\textit{ Let $F\subseteq \text{Pwrset}(\Omega)$ such that 
\begin{enumerate}
    \item $\Omega \in F$
    \item $A \in F \implies A^{C} \in F$
    \item $\{A_{k} \in F, k \in \mathbb{Z}_{+}\} \implies \cup_{k\in\mathbb{Z}_{+}}\ A_{k} \in F$
\end{enumerate}
$(\Omega, F)$ is called a measurable space. $G\subseteq F$ is called a sub-$\sigma$-algebra of $F$ if $G$ is a $\sigma$-algebra and $G\subseteq F$.
}}}

Some examples of $\sigma$-Algebras are the trivial $\sigma$-Algebra $F_{0} = \{\emptyset, \Omega\}$. And $\{\emptyset, A, A^{c}, \Omega\}$, $\forall A \in \Omega$.

We can generate a $\sigma$-Algebra, using the following proposition: Consider $\Omega$ and a familiy $\{A_{i} \subseteq \Omega, i \in I\}$. There exists a smallest $\sigma$-Algebra $F(\{A_{i}, i\in I\})$ such that $\forall i \in I$, $A_{i}\in F(\{A_{i}, i\in I\})$.


Using $\sigma$-Algebras, we can define probability measures. We can define a measure if it is $\sigma$-additive. This should hold for any countable subset.


\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Probability Measures)}.}\textit{Consider measurable space $(\Omega, F)$. The function $P: F \to \R_{+}$ called a measure if it is $\sigma$-additive:
$$
\forall \{ A_{k} \in F, k \in \mathbb{Z}_{+}\} \text{ disjoint}
$$
then this implies that 
$$
P(\cup_{k\in\mathbb{Z_{+}}A_{k}} = \sum_{k\in\mathbb{Z_{+}}} P(A_{k})
$$
$P: F \to \R_{+}$ is called a probability measure if (1) it is measureable and (2) $P(\Omega) = 1$.
}}}



We can now use this to call $(\Omega, F, P)$ a probability space if $(\Omega, F)$ is a measurable space and $P$ is a probability measure of $(\Omega, F)$.

On the real numbers we can construct probability measure as a function that assigns a probability to each element from a sample space $\Omega$.

\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Properties of Probability Measures)}.}\textit{Properties of a probability measure $(\Omega, F, P)$.
\begin{enumerate}
  \item $P(\emptyset) = 0$  
  \item Monoticity. $A_{1} \subseteq A_{2}$ implies that $P(A_{1}) \leq P(A_{2})$
  \item Subadditivity. $\{ A_{k} \in F, k \in \mathbb{Z}_{+}\}$ not neccesarily disjoint, implies that $P(\cup_{k\in\mathbb{Z}_{+}}P(A_{k})$
  \item $0 \leq P(A) \leq 1$ for all $A \in F$
\end{enumerate}
}}}

A useful result is the independence of $\sigma$-algebras. This mathematically formalizes the notion of statistical independence.



## Random Variables

\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Random Variable)}.}\textit{
Consider a probability space $k(\Omega, F)$ and a measureable space $(X, G)$. Define a random variable (rb) as a function $x: \Omega\to X$ such that , if $\forall A \in G, x^{-1}(A) = \{\omega \in \Omega| x(\omega) \in A\} \in F$
}}}

To define whether this exists or not we use indicatior function $I_{A}: \Omega \to \R$ of a subset $A \ subset \Omega$, which is defined as
$$
I_{A}(\omega) = \begin{cases}
1, \quad \omega \in A\\
0, \quad \omega \notin A \iff \omega \in A^{c}
\end{cases}
$$
This tells us that $I_{A}$ is a random variable off $A \in F$, where $F$ is a $\sigma$-Algebra.

Examples of modeling with random variables are

- Binary random variables, used in e.g. information theory, networked control
- Uniform random variables, used to represent many outcomes with equal probability such as a fair die.
- Continuous random variables can be used to measure e.g. lifetimes of devices such as lamps.


### Random Variables and $\sigma$-algebras
\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{($\sigma$-Algebras generated by random variables)}.} \textit{Consider $(\Omega, F)$, $(X, G)$ and $x: \Omega \to X$. We define the sets 
\begin{align*}
x^{-1}(A) &= \{\omega \in \Omega| X(\omega) \in A\}\\
x^{-1}(G) &= \{x^{-1}(A) \in F| \forall A \in G\}
\end{align*}
Then $x^{-1}(G)$ is a $\sigma$-algebra. We denote $F^{x}=F(x) = x^{-1}(G)$
}}}.

Random variables generate $\sigma$-algebras. Additionally, random variables induce probability measures on the range space.

\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Probability Measure Induced by RV)}.} \textit{The random variable $x: \Omega \to \R$ induces probability measure $P_{x}$ on the range space according to 
\begin{gather*}
P_{x}: B(\R)\to[0,1]\\
P_{x}(A) = P(x^{-1}(A)) = P(\{\omega \in \Omega| x(\omega) \in A\})\\
(\Omega, F, P)\mapsto^{x} (\R, B(\R), P_{x})\\
f_{x}(w) = P_{x}((-\infty, w]) \quad (\text{note this is cdf})
\end{gather*}
}}}

\fbox{\parbox{\columnwidth}{
\textbf{Definition \textnormal{(Borel Measurable Function)}.} \textit{Call a function $h: \R^{m} \to \R^{n}$ a Borel measurable function if 
$$
h^{-1}(A) = \{x \in \R^{m| h(x) \in A}\},\; \forall A \in B(\R^{n})
$$
}}}

A $\sigma$-algebra is a representation of any (nonlinear) Borel measure $y = h(x)$ such that $x$ is measurable.

### Characteristic Function
$$
\mathbb{E}\left[\exp(jw^{T}x)\right] = \int_{\R^{n}} \exp(i w^{T}v)p_{x}(v)\ dv \quad \forall w \in \R^{n}
$$
Note that the characterstic function is the **Fourier transform** of the probability density function.


## Gaussian Random Variables
A Gaussian random variable with parameters $m_{x}, Q_{x}$ is defined to be 
$$
x: \Omega \to \R^{n_{x}},\; (m_{x}, Q_{x}) \in (\R^{n_{x}} \times \R_{pds}^{n_{x}\times n_{x}}
$$
if 
$$
\mathbb{E}\left[\exp(jw^{T}x)\right] = \exp(jw^{T}m_{x} - \frac{1}{2}w^{T}Q_{x}w) \quad \forall w \in \R^{n_{x}}
$$
Note that $x\in G(m_{x}, Q_{x})$. Notation: $(x_{1}, \cdots, x_{n})$ is jointly Gaussian if 
$$
x = (x_{1},\cdots , x_{n})^{T} \in G(m_{x}, Q_{x})
$$
Where $Q_{x}\succ 0$. An important result is the following:
Affine functions of Gaussian random variables are themselves Gaussian. That is, if $x$ is a random Gaussian variable, then
$$
y = Ax + b
$$
is also Gaussian.

We can also have tuples of Gaussians:
$$
x: \Omega \to \R^{n_{x}},\; y: \Omega \to \R^{n_{y}}
$$
Then we can write 
$$
(x, y) \in G(m_{(x, y)}, Q_{(x, y)})
$$
With $Q_{(x, y)}$ the covariance matrix of $x$ and $y$. They are independent if and only if there sigma algebras $F^{x}$ and $F^{y}$ are independent, or more simply if their covariance is 0 ($Q_{x, y} = 0$). In engineering, we often represent observations as signals with noise:
$$
y = Cx + w
$$
Where $y$ is an observation, $x$ the signal and $w$ the noise. We write $(y, x, w)$ are jointly Gaussian. We usually assume that $y$ and $w$, and $x$ and $w$ are independent. $(x, w)$ are also jointly Gaussian.


## Conditional Expectation
\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Conditional Expectation of a random variable given a $\sigma$-algebra)}.}\textit{
Consider a positive random variable
\begin{gather*}
(\Omega, F), G \subseteq F\ \text{sub-$\sigma$-algebra of $F$}\\
x: \Omega \to \R_{+}, \mathbb{E}\left[x\right] < \infty
\end{gather*}
There exists a random variable 
$$
\mathbb{E}\left[x|G\right]: \Omega \to \R_{+}
$$
such that $\mathbb{E}\left[x | G\right]$ is $G$-measurable and $\mathbb{E}\left[x\ I_{A}\right]$ = $\mathbb{E}\left[\mathbb{E}\left[x|G\right]\ I_{A}\right]$, $\forall A \in G$, hence $\mathbb{E}\left[\mathbb{E}\left[x|G\right]\right] = \mathbb{E}\left[x\right] < \infty$
}}}
The definition above is unique up to an almost sure modification. That is, the difference goes to $0$ with expectation $1$.


\fbox{\parbox{\columnwidth}{
\textbf{Theorem \textnormal{(Properties of Conditional Epectation)}.} \textit{Consider $(\Omega, F, P), G, G_{1}, G_{2} \subseteq F$. $x, y: \Omega \to \R$, $\mathbb{E}[x] < \infty$, $\mathbb{E}[y] < \infty$
\begin{enumerate}
    \item Linearity, $\mathbb{E}\left[ax + by | G\right] = a\mathbb{E}\left[x|G\right] + b\mathbb{E}\left[y| G\right]$
    \item Order Preservation, $x \leq y \implies \mathbb{E}\left[x | G\right] \leq \mathbb{E}\left[y | G\right]$
    \item Measurability, $y$ is $G$ measurable, then $\mathbb{E}\left[xy|G\right] = y \mathbb{E}\left[x | G\right]$, in particular $\mathbb{E}\left[y|G\right] = y$
    \item Reconditioning, $G_{1} \subseteq G_{2} \implies \mathbb{E}\left[x | G_{1}\right] = \mathbb{E}\left[\mathbb{E}\left[x | G_{2}\right]| G_{1}\right]$ and in particular $\mathbb{E}\left[\mathbb{E}\left[x|G\right]\right] = \mathbb{E}\left[x\right]$
    \item Independence, $F^{x}$ and $G$ independent implies that $\mathbb{E}\left[x | G\right] = \mathbb{E}\left[x\right]$
\end{enumerate}
}}}


For simple random variable, we define variables in terms of an indicator function representation:
$$
y = C_{y}i_{y} = \sum_{k=1}^{n_{i_{y}}} C_{y, k}i_{y,k}
$$
