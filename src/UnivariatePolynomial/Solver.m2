-- Initalize the field of rationals and the univariate polynomial ring.
R = QQ;
S = RR[x];

-- Load a well-established polynomial system solver
loadPackage "NumericalAlgebraicGeometry"

-- Compute the degree of the univariate polynomial based on coeffList
-- Input: coeffList {an, ..., a1, a0} of the polynomial a0 + a1*x + ... + an*x^n
-- Output: degree of the polynomial
computeDegree = (coeffList) -> (
    last   := length coeffList - 1;
    output := length coeffList - 1;
    for i from 0 to last do (
        if coeffList#i == 0 then (
            output = output - 1;
        )
        else break;
    );
    output
)

-- Reduce the coefficient list to become the list of a monic polynomial
-- Input: coeffList {an, ..., a1, a0} of the polynomial a0 + a1*x + ... + an*x^n
-- Output: {a_(d-1)/a_d, a_(d-2)/a_d, ..., a_0/a_d} if degree of polynomial is d
reduceCoeffList = (coeffList) -> (
    output     := coeffList;
    d          := computeDegree(coeffList);
    last       := length coeffList - 1;
    startIndex := last - d; -- the index with first nonzero coefficient
    if d >= 0 and startIndex >= -1 then (
        startCoeff := coeffList#startIndex;
        output     = new MutableList from coeffList_{(startIndex + 1)..last};
        for i from 0 to (d-1) do (
            output#i = output#i / startCoeff;
        )
    );
    output = toList output; -- convert to immutable list
    output
)

-- Compute a univariate polynomial
-- Input: coeffList {an, ..., a1, a0} of the polynomial a0 + a1*x + ... + an*x^n
computeUnivariatePolynomial = (coeffList) -> (
    last       := length coeffList - 1;
    output     := sub(coeffList#(last), S);
    d          := computeDegree(coeffList);
    startIndex := last - d;
    if (d >= 0 and startIndex >= -1) then (
        for i from startIndex to (last - 1) do (
            power := last - i;
            output = output + (coeffList#i)*x^power;
        )
    );
    output
)

-- Compute the companion matrix of a univariate polynomial
-- Input: coeffList {an, ..., a1, a0} of the polynomial a0 + a1*x + ... + an*x^n
computeCompanionMatrix = (coeffList) -> (
    output := sub(matrix{{0}}, R);
    d      := computeDegree(coeffList);

    -- Reduce the coeffient list to a compact form with the polynomial being monic
    reducedList := reduceCoeffList(coeffList);

    if d >= 1 then (
        zeroRow  := map(R^1, R^(d-1), (i, j)->0);
        identity := id_(R^(d-1));
        column   := map(R^d, R^1, (i, j)->(-1)*reducedList#(d-i-1));
        output    = (zeroRow || identity) | column;
    );
    output
)

-- Find all roots of a univariate polynomial a0 + a1*x + ... + an*x^n
-- Input: coeffList {an, ..., a1, a0}
solveUnivariatePolynomial = (coeffList) -> (
    polyl           := computeUnivariatePolynomial(coeffList);
    companionMatrix := computeCompanionMatrix(coeffList);
    e               := eigenvalues companionMatrix;
    roots           := toList e;
    output          := (polyl, roots);
    output
)

main0 = () -> (
    L     := {1,2,3,4};
    (p, r) = solveUnivariatePolynomial(L)
)

-- Compute our solver with the well-established one
main1 = () -> (
    L      := {1,2,3,4};
    (p, r) := solveUnivariatePolynomial(L);
    solveSystem {p}
)

main2 = () -> (
    L     := {0,0,0,1,2,3,4};
    (p, r) = solveUnivariatePolynomial(L)
)

main3 = () -> (
    L     := {0};
    (p, r) = solveUnivariatePolynomial(L)
)

main4 = () -> (
    L     := {3};
    (p, r) = solveUnivariatePolynomial(L)
)
