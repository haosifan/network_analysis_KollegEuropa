bipartite_closeness_centrality <- function(g){
  if (!is.null(V(g)$type)){
    # determine maximal raw scores for both vertex subsets
    mrs_TRUE <- length(V(g)[type==FALSE]) + 2*length(V(g)[type==TRUE]) - 2
    mrs_FALSE <- length(V(g)[type==TRUE]) + 2*length(V(g)[type==FALSE]) - 2
    # get sum of all geodesic paths for each vertex
    sp <- shortest.paths(g)
    sp[sp==Inf] <- length(V(g))
    rowsums_shortest_paths <- rowSums(sp)
    # "bipartite" normalization of scores
    for (i in V(g)){
      if (V(g)[i]$type==TRUE){
        V(g)[i]$closeness.centrality <- mrs_TRUE/rowsums_shortest_paths[i+1]
      }
      else{
        V(g)[i]$closeness.centrality <- mrs_FALSE/rowsums_shortest_paths[i+1]
      }
    }
    # return value as list
    return(list("Bipartite.Closeness.Centrality"=V(g)$closeness.centrality))
  }
  else {
    # boolean vertex attribute 'type' is required
    cat("vertex attribute <type> is missing")
  }
}