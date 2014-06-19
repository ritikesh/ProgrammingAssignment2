### Introduction

This second programming assignment is an R
function that is able to cache potentially time-consuming computations.
For example, taking the inverse of a numeric matrix is typically a fast
operation. However, for a very long matrix, it may take too long to
compute the inverse, especially if it has to be computed repeatedly (e.g.
in a loop). If the contents of a matrix are not changing, it may make
sense to cache the value of the inverse so that when we need it again, it
can be looked up in the cache rather than recomputed. In this
Programming Assignment you will take advantage of the scoping rules of
the R language and how they can be manipulated to preserve state inside
of an R object.

The `<<-` operator is used to
assign a value to an object in an environment that is different from the
current environment. Below are two functions that are used to create a
special object that stores a numeric Matrix and caches its inverse.

The first function, `makeMatrix` creates a special "Matrix", which is
really a list containing a function to

1.  set the value of the Matrix
2.  get the value of the Matrix
3.  set the value of the inverse
4.  get the value of the inverse

<!-- -->

    makeCacheMatrix <- function(x = matrix()) {
    i <- NULL               
    set <- function(y) {
        x <<- y             
        i <<- NULL          
    }
    get <- function() x     
    setinverse <- function(inverse) i <<- inverse     
    getinverse <- function() i                        
    list(set = set, get =get, setinverse = setinverse, getinverse = getinverse)
}

The following function calculates the inverse of the special "Matrix"
created with the above function. However, it first checks to see if the
inverse has already been calculated. If so, it `get`s the inverse from the
cache and skips the computation. Otherwise, it calculates the inverse of
the data and sets the value of the inverse in the cache via the `setinverse`
function.

    cacheSolve <- function(x, ...) {
    i <- x$getinverse()     
    if(!is.null(i)) {       
        message("Getting Cached Data")
        return(i)           
    }
    data <- x$get()         
    i <- solve(data, ...)   
    x$setinverse(i)         
    i        
}
