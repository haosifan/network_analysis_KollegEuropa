bipartite_betweenness_centrality <-
  function(g){
    if (!is.null(V(g)$type)){
      # determine maximal raw scores for both vertex subsets
      if (length(V(g)[type==FALSE])<length(V(g)[type==TRUE])){
        mrs_TRUE <- 2*(length(V(g)[type==FALSE])-1)*(length(V(g)[type==TRUE])-1)
      }
      else{
        mrs_TRUE <- 0.5*length(V(g)[type==FALSE])*(length(V(g)[type==FALSE])-1)+0.5*(length(V(g)[type==TRUE])-1)*(length(V(g)[type==TRUE])-2)+(length(V(g)[type==FALSE])-1)*(length(V(g)[type==TRUE])-1)
      }
      if (length(V(g)[type==TRUE])<length(V(g)[type==FALSE])){
        mrs_FALSE <- 0.5*length(V(g)[type==TRUE])*(length(V(g)[type==TRUE])-1)+0.5*(length(V(g)[type==FALSE])-1)*(length(V(g)[type==FALSE])-2)+(length(V(g)[type==TRUE])-1)*(length(V(g)[type==FALSE])-1)
        
      }
      else{
        mrs_FALSE <- 2*(length(V(g)[type==TRUE])-1)*(length(V(g)[type==FALSE])-1)
      }
      
      # get raw betweenness centrality scores from igraph
      betweenness_rs <- betweenness(g,directed=FALSE)
      # "bipartite" normalization of scores
      for (i in V(g)){
        if (V(g)[i]$type==TRUE){
          V(g)[i]$betweenness.centrality <- betweenness_rs[i+1]/mrs_TRUE
        }
        else{
          V(g)[i]$betweenness.centrality <- betweenness_rs[i+1]/mrs_FALSE
        }
      }
      # return value as list
      return(list("Bipartite.Betweenness.Centrality"=V(g)$betweenness.centrality))
    }
    else {
      # boolean vertex attribute 'type' is required
      cat("vertex attribute <type> is missing")
    }
  }