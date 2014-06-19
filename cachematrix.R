## Simple operations such as matrix inversion can become complex when operating on large matrices.
## To faster the computation, the results are cached and recomputed only when the matrix elements changes. 

## makeCacheMatrix creates a special object that stores a numeric matrix and cache's it's inverse.

makeCacheMatrix <- function(x = matrix()) {
    i <- NULL               ## Initialize cache to NULL on creation
    set <- function(y) {
        x <<- y             ## Assign data passed to the environment's object
        i <<- NULL          ## If matrix elements change, clear the cache and set it to Null
    }
    get <- function() x     ## Retrieve Matrix elements
    setinverse <- function(inverse) i <<- inverse     ## Set Inverse value of the matrix
    getinverse <- function() i                        ## Get the Inverse value for the matrix
    list(set = set, get =get, setinverse = setinverse, getinverse = getinverse)
}


## cacheSolve computes the inverse of the matrix and stores it on the makeCacheMatrix object's environment for faster access.

cacheSolve <- function(x, ...) {
    i <- x$getinverse()     ## Check if cache already set
    if(!is.null(i)) {       
        message("Getting Cached Data")
        return(i)           ## If cache is set, returns the inverse value already cached.
    }
    data <- x$get()         ## If Inverse has not been cached, get matrix data
    i <- solve(data, ...)   ## Compute the inverse using the SOLVE function
    x$setinverse(i)         ## Set the Cache value on the makeCacheMatrix object
    i        ## Return a matrix that is the inverse of 'x'
}
