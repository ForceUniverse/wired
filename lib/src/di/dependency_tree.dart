part of force_it;

class DependencyTree {
  List<DependencyTreeInfo> dependencyTreeList = new List<DependencyTreeInfo>();
  
  void add(DependencyTreeInfo dti) => dependencyTreeList.add(dti);
  
  void sort() => dependencyTreeList.sort((a, b) => a.compareTo(b));

}

class DependencyTreeInfo extends Comparable {
  
  MetaDataValue mdv;
  List<MetaDataValue> dependsOn = new List<MetaDataValue>();
  
  DependencyTreeInfo(this.mdv, [this.dependsOn]);
  
  addDependency(MetaDataValue dependencyMetaData) {
    this.dependsOn.add(dependencyMetaData);
  }
  
  compareTo(other) {
    return other.dependsOn.length < this.dependsOn.length ? -1 : 1;
  }
  
}