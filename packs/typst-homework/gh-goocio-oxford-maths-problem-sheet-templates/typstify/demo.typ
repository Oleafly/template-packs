#set text(size: 10pt, font: "New Computer Modern")
#set par(justify: true)
#set enum(numbering: n => [*(#n)*])
#let parts(body) = {set enum(numbering: n => strong(numbering("(a)",n))); body}
#let subparts(body) = {set enum(numbering: n => strong(numbering("(i)",n))); body}
#let solution(body) = block(
	stroke: 1pt + rgb(40, 40, 40, 200), radius: 1pt, width: 100%, inset: 1em, strong("Solution:") + v(0pt) + body
)
#let mb(body) = math.upright(math.bold(body))

#align(center, text(1.75em)[Metric Spaces -- Sheet 1\ Continuity, 2-adic metric])
#align(center, text(1.4em)[YOUR NAME HERE :)])
#align(center, text(1.2em)[Michaelmas Term 2024])

[_You may find it helpful in some examples to work with polar coordinates._]

	
+ /* 1 */ The function $f:bb(R)^(2) -> bb(R)$ is defined by $ 
		f(x,y)=cases(
			(|x y|^(alpha))/(x^(2)+y^(2))  quad&  "for" (x comma y)!=(0 comma 0)semi ,
			0  quad&  "for" (x comma y)=(0 comma 0)comma 
		)
	 $ where $alpha>0$. Find the values of $alpha$ for which $f$ is
	#parts[
		+ /* 1a */ continuous at $(0,0)$;
			#subparts[
				+ /* 1ai */ This sheet doesn't actually have any questions with subparts,
					
				+ /* 1aii */ so I've added a couple in for demonstration purposes.
			]
			
		+ /* 1b */ differentiable at $(0,0)$.
	]
	
	
	
+ /* 2 */ Let $f:bb(R)^(2) -> bb(R)$ be defined by $ 
		f(x,y)=cases(
			(x y^(2))/(x^(2)+y^(4))  quad&  "for" (x comma y)!=(0 comma 0)semi ,
			0  quad&  "for" (x comma y)=(0 comma 0).
		)
	 $ Show that all the directional derivatives of $f$ exist at the origin, but $f$ is not continuous at the origin.
	
	
	
+ /* 3 */ Let $f:bb(R)^(2) -> bb(R)$ and assume that on some disk $U subset.eq bb(R)^(2)$ with centre the origin $(0,0)$ we have that the partial derivatives $f_(x)$ and $f_(y)$ exist, and moreover $f_(x y)$ exists and is continuous.
	#parts[
		+ /* 3a */ Prove that $f_(y x)(0,0)$ is equal to the following limit, provided this limit exists: $ 
				lim_(h -> 0)(lim_(k -> 0)F(h,k))
			 $ where $ 
				F(h,k)=((f(h,k)-f(h,0))-(f(0,k)-f(0,0)))/(h k).
			 $
			
		+ /* 3b */ Let $phi.alt(x)=f(x,k)-f(x,0)$. Using the Mean Value Theorem show that $ 
				F(h,k)=(1)/(k) dot.c phi.alt_(x)(theta_(1)h)
			 $ for some $0<theta_(1)<1$.
			
		+ /* 3c */ Deduce further that $ 
				F(h,k)=f_(x y)(theta_(1)h,theta_(2)k)
			 $ for some $0<theta_(2)<1$.
			
		+ /* 3d */ Use the continuity of $f_(x y)$ and existence of $f_(y)$ to conclude that $f_(y x)(0,0)$ exists and equals $f_(x y)(0,0)$. [_Beware, part (iv) is very delicate. Note that $theta_(1)=theta_(1)(h,k)$ and $theta_(2)=theta_(2)(h,k)$. The dependence of $theta_(1)$ on $k$ makes life difficult._]
	]
	
	
	
+ /* 4 */ Let $ 
		f(x, y)=cases(
			(x y(x^(2)-y^(2)))/(x^(2)+y^(2))  quad&  "for" (x comma y)!=(0 comma 0)semi ,
			0  quad&  "for" (x comma y)=(0 comma 0).
		)
	 $
	#parts[
		+ /* 4a */ Show that $f in C^(1)(bb(R)^(2),bb(R))$, that is, $f$ has continuous partial derivatives everywhere. [_You may assume that rational functions in $x$ and $y$ are continuous wherever they are defined._]
			
		+ /* 4b */ For $(a,b)!=(0,0)$ show that $f_(x y)(a,b)$ and $f_(y x)(a,b)$ exist and are equal.
			
		+ /* 4c */ However, prove that $f_(x y)(0,0)=-1$ and $f_(y x)(0,0)=1$.
	]
	
	
	
+ /* 5 */ Let $U subset.eq bb(R)^(2)$ and $u_(0), u_(1) in U$. Let $P_(0,1)$ denote the set of all paths between $u_(0)$ and $u_(1)$. Show that homotopy defines an equivalence relation on $P_(0,1)$.
	
	
	
+ /* 6 */ Assume $U subset.eq bb(R)^(2)$ is _convex_ (that is to say, the straight line segment joining any two points $u, v in U$ lies wholly within $U$), show that $U$ is path-connected. Moreover for any $u in U$, prove carefully that any path joining $u$ and $u$ is homotopic to the trivial path.
	
	
	
+ /* 7 */ Show that there is no continuous injective map $f: bb(R)^(2) -> bb(R)$. [_Hint: consider the restriction of $f$ to $bb(R)^(2) without{a}$, for a suitable point a._]
	
	
	
+ /* 8 */ Let $A subset.eq bb(R)^(2)$ be the set of all points with at least one rational coordinate. Is $A$ connected? What if the points with both coordinates rational are removed from $A$?
	
	
	
+ /* 9 */ Which of the following subsets of $bb(R)^(2)$ are open, which are closed, and which are neither? (No proofs are required.) $ 
		[0,1]times{0},wide
		(0,1)times{0},wide
		{(x,y):1<4 x^(2)+y^(2)<4},\ 
		{(x, y): x y=1}wide
		bb(Z) times bb(R),wide
		{(x,y): x in bb(Z)  "and"  y>0}.
	 $
	
	
	
+ /* 10 */ Let $f: bb(R)^(2) -> bb(R)^(2)$ be defined as $f(x, y)=(e^(x) cos (y), e^(x) sin (y))$. Show that $f$ has a local inverse in a neighbourhood of any point in $bb(R)^(2)$, but does not have an inverse defined on the whole of $bb(R)^(2)$.
	
	
	
+ /* 11 */ By considering the function defined by $ 
		f(x)=(x)/(2)+x^(2) sin ((1)/(x) ) "for" x != 0;quad
		f(0)=0
	 $ show that the assumption on continuous partial derivatives cannot be removed from the statement of the Inverse Function Theorem in $bb(R)^(2)$.