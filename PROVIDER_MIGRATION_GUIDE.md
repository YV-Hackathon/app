# Provider Migration Guide

## Overview

The API returns 4 questions in one call. We now have:

- **1 shared provider** (`questionNotifierProvider`) that fetches all questions
- **4 derived providers** that select specific questions by index

## Provider Structure

### Base Provider (already exists)

```dart
questionNotifierProvider // Fetches all questions, manages state
```

### Derived Providers (new)

```dart
// Index 0: Speakers (converted to Speaker entities)
speakersProvider → List<Speaker>
selectedSpeakersProvider → List<String> (IDs)

// Index 1: Bible Reading Preference
bibleReadingQuestionProvider → Question?

// Index 2: Teaching Style Preference
teachingStyleQuestionProvider → Question?

// Index 3: Environment Preference
environmentQuestionProvider → Question?

// Utility providers
questionsLoadingProvider → bool
questionsErrorProvider → String?
```

## Screen Mappings

### 1. SimpleOnboardingPage (Speakers Selection)

**Import:**

```dart
import '../providers/specific_question_providers.dart';
import '../providers/question_provider.dart';
```

**Watch providers:**

```dart
final speakers = ref.watch(speakersProvider);
final isLoading = ref.watch(questionsLoadingProvider);
final error = ref.watch(questionsErrorProvider);
final notifier = ref.read(questionNotifierProvider.notifier);
```

**Toggle speaker:**

```dart
onTap: () => notifier.toggleSpeaker(speaker.id)
```

**Get selected speakers:**

```dart
final selectedSpeakers = notifier.getSelectedSpeakers();
```

---

### 2. QuestionPage (Bible Reading Preference)

**Import:**

```dart
import '../providers/specific_question_providers.dart';
import '../providers/question_provider.dart';
```

**Watch providers:**

```dart
final question = ref.watch(bibleReadingQuestionProvider);
final isLoading = ref.watch(questionsLoadingProvider);
final error = ref.watch(questionsErrorProvider);
final notifier = ref.read(questionNotifierProvider.notifier);
```

**Select answer:**

```dart
onTap: () => notifier.selectAnswer(question!.id, option.id)
```

---

### 3. TeachingStylePage (Teaching Style Preference)

**Import:**

```dart
import '../providers/specific_question_providers.dart';
import '../providers/question_provider.dart';
```

**Watch providers:**

```dart
final question = ref.watch(teachingStyleQuestionProvider);
final isLoading = ref.watch(questionsLoadingProvider);
final error = ref.watch(questionsErrorProvider);
final notifier = ref.read(questionNotifierProvider.notifier);
```

**Select answer:**

```dart
onTap: () => notifier.selectAnswer(question!.id, option.id)
```

---

### 4. ChurchEnvironmentPage (Environment Preference)

**Import:**

```dart
import '../providers/specific_question_providers.dart';
import '../providers/question_provider.dart';
```

**Watch providers:**

```dart
final question = ref.watch(environmentQuestionProvider);
final isLoading = ref.watch(questionsLoadingProvider);
final error = ref.watch(questionsErrorProvider);
final notifier = ref.read(questionNotifierProvider.notifier);
```

**Select answer:**

```dart
onTap: () => notifier.selectAnswer(question!.id, option.id)
```

---

## Speaker Image URLs

Speaker images are automatically mapped to:

```dart
'assets/speakers/${speakerId}.png'
```

Make sure your speaker images are named with their IDs:

- `assets/speakers/31.png`
- `assets/speakers/32.png`
- etc.

Or use the existing speaker images you already have in `assets/speakers/` directory.

## Error Handling Pattern

All screens should handle loading and error states:

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final isLoading = ref.watch(questionsLoadingProvider);
  final error = ref.watch(questionsErrorProvider);

  if (isLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (error != null) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: $error'),
          ElevatedButton(
            onPressed: () => ref.read(questionNotifierProvider.notifier).retry(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // Your screen content here
}
```

## Benefits

✅ **Single API call** - All questions fetched once  
✅ **Efficient caching** - Shared state across screens  
✅ **Type safety** - Speakers auto-converted to Speaker entities  
✅ **Simple updates** - Change one provider, all screens update  
✅ **Better performance** - No redundant API calls
