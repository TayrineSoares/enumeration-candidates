# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

def find(id)
  @candidates.find { |candidate| candidate[:id] == id }
end

  
def experienced?(candidate)
  candidate[:years_of_experience] >= 2
end
  
# select is a built-in Ruby method used with arrays. 
# It filters the array and returns a new array that includes only the elements that match a condition.
def qualified_candidates(candidates)
  candidates.select do |candidate|
    experienced?(candidate) &&
    has_enough_github_points?(candidate) &&
    knows_ruby_or_python?(candidate) &&
    applied_recently?(candidate) &&
    of_age?(candidate)
  end
end
  
# METHODS FOR QUALIFIED CANDIDATES
def has_enough_github_points?(candidate)
  candidate[:github_points] >= 100
end

def knows_ruby_or_python?(candidate)
  candidate[:languages].include?('Ruby') || candidate[:languages].include?('Python')
end

def applied_recently?(candidate)
  candidate[:date_applied] >= 15.days.ago.to_date
end

def of_age?(candidate)
  candidate[:age] >= 18
end

# METHOD TO ORDER BY QUALIFICATIONS

# sort_by: sorts the array based on the values returned in the block.
# We use negative values because Ruby sorts in ascending order by default. 
# By negating the values, we can make it sort in descending order
def ordered_by_qualifications(candidates)
  candidates.sort_by { |candidate| [-candidate[:years_of_experience], -candidate[:github_points]] }
end