---     
  ```{r gov_data_reshape, echo=FALSE, comment=FALSE, warning=FALSE, cache=FALSE}
gov11 <- loadWorkbook("~/Documents/NRT/scomms/Github/governance_ppt/slides/gov_scores.xlsx")
gov12 <- readWorksheet(gov11, 1)

gov12$finc <- gov12$annual_audit + gov12$budget_process + gov12$budget_execution + gov12$revenue_publication + gov12$fundraising
gov12$admin <- gov12$registration + gov12$hr_procedures + gov12$annual_audit + gov12$budget_execution + gov12$revenue_sharing_bylaws + gov12$asset_management
gov12$transparency <- gov12$agm + gov12$community_support + gov12$board_rotation + gov12$hr_procedures + gov12$annual_audit +gov12$revenue_sharing_bylaws
gov12$growth <- gov12$registration + gov12$community_support + gov12$fundraising + gov12$donor_relations + gov12$partnerships
gov12$ccy_support <- gov12$community_support + gov12$partnerships + gov12$registration + gov12$agm + gov12$board_rotation

library(reshape)
gov9 <- reshape(gov12,
                varying=c("performance_score",
                          "finc",
                          "ccy_support",
                          "growth",
                          "admin",
                          "transparency"),
                v.names="gov_score",
                timevar="gov_parameter",
                times=c("performance_score",
                        "finc",
                        "ccy_support",
                        "growth",
                        "admin",
                        "transparency"),
                direction="long")
```

```{r gov8, echo=FALSE}
gov8 <- as.data.frame(gov9)
gov8$gov_parameter <- as.factor(gov8$gov_parameter)
gov8$conservancy <- as.factor(gov8$conservancy)
```

```{r shiny_ui, opts.label = 'shiny', cache=TRUE}
slidifyUI(
  sidebarPanel(
    selectInput('year','Choose Year', c('2012', '2013', "2014"))
  ),
  
  mainPanel(
    tags$div(id='nvd3plot', class='shiny-html-output nvd3 rChart')
  )
)

```