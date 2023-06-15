class Transaction {
  String? timeStamp;
  String? from;
  String? to;
  String? value;
  String? gasUsed;

  Transaction({
    this.timeStamp,
    this.from,
    this.to,
    this.value,
    this.gasUsed,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'];
    from = json['from'];
    to = json['to'];
    value = json['value'];
    gasUsed = json['gasUsed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timeStamp'] = timeStamp;
    data['from'] = from;
    data['to'] = to;
    data['value'] = value;
    data['gasUsed'] = gasUsed;
    return data;
  }
}
