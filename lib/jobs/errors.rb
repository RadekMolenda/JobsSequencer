module Jobs
  class JobsCantDependOnThemselvesError < StandardError
  end
  class JobsCantHaveCircularDependenciesError < StandardError
  end
end
