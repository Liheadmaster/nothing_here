package edu.umn.cs.recsys.ii;

import org.grouplens.lenskit.basic.AbstractGlobalItemScorer;
import org.grouplens.lenskit.scored.ScoredId;
import org.grouplens.lenskit.vectors.MutableSparseVector;
import org.grouplens.lenskit.vectors.VectorEntry;

import javax.annotation.Nonnull;
import javax.inject.Inject;

import java.util.Collection;
import java.util.HashMap;

/**
 * Global item scorer to find similar items.
 * @author <a href="http://www.grouplens.org">GroupLens Research</a>
 */
public class SimpleGlobalItemScorer extends AbstractGlobalItemScorer {
    private final SimpleItemItemModel model;

    @Inject
    public SimpleGlobalItemScorer(SimpleItemItemModel mod) {
        model = mod;
    }

    /**
     * Score items with respect to a set of reference items.
     * @param items The reference items.
     * @param scores The score vector. Its domain is the items to be scored, and the scores should
     *               be stored into this vector.
     */
    @Override
    public void globalScore(@Nonnull Collection<Long> items, @Nonnull MutableSparseVector scores) {
        scores.fill(0);
        
        // TODO score items in the domain of scores
        // each item's score is the sum of its similarity to each item in items, if they are
        // neighbors in the model.
        for (VectorEntry ent : scores){
        	long item = ent.getKey();
        	HashMap mappedNeighbor = new HashMap();
            for (ScoredId _sid: model.getNeighbors(item)){
            	mappedNeighbor.put(_sid.getId(), _sid.getScore());
            }
            double _score = 0.0;
        	for (long compareItem : items){
        		if (item == compareItem || !mappedNeighbor.containsKey(compareItem)) continue;
        		_score += (Double)mappedNeighbor.get(compareItem);
        	}
        	scores.set(item, _score);
        }
    }
}
