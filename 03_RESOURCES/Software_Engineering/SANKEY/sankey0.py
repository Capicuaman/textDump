import plotly.graph_objects as go

fig = go.Figure(go.Sankey(
    arrangement='snap',
    node=dict(
        label=["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
        align='left'

    ),
    link=dict(
        arrowlen=15,
        source=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        target=[8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9],
        value=[4, 2, 3, 1, 2, 1, 1, 10, 1, 1 ]
    )
))

fig.show()