word_list = ['foo','bar'k9-o,'widget','foot','bark','fidget']
word2hist = {}
hist2word = {}
word_list.each do |word|
  h = calc_hist(word) # {'letter_qty': x, 'a': qty, ...}
  hist2word[h] = [] unless hist2word.keys.include?(h)
  hist2word[h] << word
  word2hist[word] = h
end
hdist1 = {}
h2wk = hist2word.keys
l = h2wk.length
l_m1 = l - 1
h2wk.each_with_index do |k1, i|
  (i+1..l_m1).each do |j|
    k2 = h2wk[l]
    delta = k1['letter_qty'] - k2['letter_qty']
    if [-1,0,1].include?(delta)
      hdas = hist_delta_abs_sum(k1,k2) # {'delta_abs_sum': x, 'da': qty, ...}
      if [-2,-1,1,2].include?(hdas)
        hdist1[k1] = [] unless hdist.keys.include?(k1)
        hdist1[k2] = [] unless hdist.keys.include?(k2)
        hdist1[k1] << k2
        hdist1[k2] << k1
      end
    end
  end
end

def calc_hist(word) # {'letter_qty': x, 'a': qty, ...}
end

def hist_delta_abs_sum(k1,k2) # {'delta_abs_sum': x, 'da': qty, ...}
end

def hist_friends_except(hist_key, friends_new_prev = [], friends_all = [], depth = 0) # [[],[],...]
  friends_close = hdist1[hist_key]
  friends_new = friends_close - [hist_key] - friends_new_prev - friends_all.flatten
  # return friends if friends_new.empty?
  unless friends_new.empty?
    friends_all[depth] = [] unless defined?(friends_all[depth])
    friends_all[depth] << friends_new
    friends_new.each do |fn|
      hist_friends_except(fn, friends_new, friends_all, depth + 1)
    end
  end
  return friends_all
end

def word_friends_except(word, friends_flat_uniq) # [[],[],...]
end

hist_friends = {}
h2wk.each do |k|
  hist_friends[k] = hist_friends_except(k, [])
  
end


friends = {}
word_list.each do |k|
  friends[k] = word_friends_except(k, [])
  
end

