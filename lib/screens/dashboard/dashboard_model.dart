class DashboardModel {
    int? rate;
    int? total;

    DashboardModel({
        this.rate,
        this.total,
    });

    factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        rate: json["rate"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "rate": rate,
        "total": total,
    };
}