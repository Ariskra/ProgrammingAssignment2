## Put comments here that give an overall description of what your
## functions do

## THe makeCacheMatrix function creates a special "matrix" object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
    inverse_matrix <- NULL
    set <- function(y) {
        x <<- y
        inverse_matrix <<- NULL
    }
    get <- function() x
    set_inverse_matrix <- function(inv_matr) inverse_matrix <<- inv_matr
    get_inverse_matrix <- function() inverse_matrix
    list(set = set, get = get, set_inverse_matrix = set_inverse_matrix, get_inverse_matrix = get_inverse_matrix)
}


## The cacheSolve function computes the inverse of the special "matrix" returned by makeCacheMatrix above

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
    inverse_matrix <- x$get_inverse_matrix()
    if(!is.null(inverse_matrix)) {
        message("getting cached data")
        return(inverse_matrix)
    }
    data <- x$get()
    inverse_matrix <- solve(data, ...)
    x$set_inverse_matrix(inverse_matrix)
    inverse_matrix
}
