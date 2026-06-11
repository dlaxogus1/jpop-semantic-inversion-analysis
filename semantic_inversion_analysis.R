library(dplyr)
library(ggplot2)

# 데이터 불러오기
df <- read.csv("J-Pop_semantic_inversion.csv")

# 컬럼명 변경
df <- df %>%
  rename(
    surface = `Surface.Positivity`,
    sadness = `Underlying.Sadness`,
    type = `Inversion.Type`,
    affection = `Underlying.Affection`
  )

# 세부 유형을 상위 유형으로 분류
df <- df %>%
  mutate(
    type_group = case_when(
      
      # 사랑하지만 닿을 수 없음
      type %in% c(
        "hopeless_affection",
        "impossible_proximity",
        "lonely_romanticism",
        "unreachable_affection",
        "hopeless_connection"
      ) ~ "unattainable_love",
      
      # 자기 부정
      type %in% c(
        "self_unworthiness",
        "self_erasure",
        "identity_loss",
        "self_negating_love"
      ) ~ "self_negation",
      
      # 과거 회상 및 상실 이후 감정
      type %in% c(
        "nostalgic_reframing",
        "nostalgic_love",
        "positive_loss",
        "persistence_after_loss",
        "symbolic_loss"
      ) ~ "nostalgic_emotion",
      
      # 아름답게 표현된 슬픔
      type %in% c(
        "painful_beauty",
        "beautiful_disappearance",
        "warmth_in_coldness",
        "romanticized_death"
      ) ~ "aesthetic_sadness",
      
      # 불안정한 관계
      type %in% c(
        "fragile_connection",
        "emotional_imbalance",
        "unstable_affection",
        "fear_of_perception",
        "connection_anxiety"
      ) ~ "unstable_relationship",
      
      TRUE ~ "other"
    )
  )

# 감정 반전 강도 계산
# Surface Positivity와 Sadness가 동시에 높을수록 강한 반전
df <- df %>%
  mutate(
    inversion_strength = surface * sadness
  )

# 산점도 생성
plot <- ggplot(
  df,
  aes(
    x = surface,
    y = sadness,
    size = affection,
    color = type_group
  )
) +
  geom_point(alpha = 0.8) +
  geom_vline(
    xintercept = 0.5,
    linetype = "dashed",
    color = "gray50"
  ) +
  geom_hline(
    yintercept = 0.5,
    linetype = "dashed",
    color = "gray50"
  ) +
  xlim(0, 1) +
  ylim(0, 1) +
  labs(
    title = "Semantic Inversion in J-Pop Lyrics",
    x = "Surface Positivity",
    y = "Underlying Sadness",
    size = "Underlying Affection",
    color = "Type Group"
  ) +
  theme_minimal()

print(plot)

# 그래프 저장
ggsave(
  "semantic_inversion_plot.png",
  plot = plot,
  width = 8,
  height = 6,
  dpi = 300
)

# 유형별 평균
type_summary <- df %>%
  group_by(type_group) %>%
  summarise(
    avg_surface = mean(surface, na.rm = TRUE),
    avg_sadness = mean(sadness, na.rm = TRUE),
    avg_affection = mean(affection, na.rm = TRUE),
    avg_inversion = mean(inversion_strength, na.rm = TRUE)
  )

print(type_summary)

# 곡별 평균
song_summary <- df %>%
  group_by(song) %>%
  summarise(
    avg_surface = mean(surface, na.rm = TRUE),
    avg_sadness = mean(sadness, na.rm = TRUE),
    avg_affection = mean(affection, na.rm = TRUE),
    avg_inversion = mean(inversion_strength, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_inversion))

print(song_summary)

# 감정 반전이 강한 가사 순위
top_inversions <- df %>%
  arrange(desc(inversion_strength)) %>%
  select(
    song,
    lyric,
    surface,
    sadness,
    affection,
    inversion_strength
  )

print(top_inversions)
